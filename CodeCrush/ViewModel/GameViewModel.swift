import Foundation
import UIKit

protocol GameViewModelDelegate: AnyObject {
    func onGameStarted()
    func onGridUpdated(removed: Set<GameItem>, newItems: [[GameItem]], shifted: [[GameItem]])  // Detailed update for animation
    func onScoreUpdated(newScore: Int)
    func onMoveLimitUpdated(movesLeft: Int)
    func onGameOver(isWin: Bool)
    func onInvalidSwap(from: GameItem, to: GameItem)  // Bounce animation
}

class GameViewModel {

    private let engine = GameEngine()
    private var level: Level

    weak var delegate: GameViewModelDelegate?

    private(set) var score = 0 {
        didSet { delegate?.onScoreUpdated(newScore: score) }
    }

    private(set) var movesLeft = 0 {
        didSet { delegate?.onMoveLimitUpdated(movesLeft: movesLeft) }
    }

    // State
    private var selectedItem: GameItem?
    private var isProcessing = false

    init(levelIndex: Int = 1) {
        // Simple logic: Target Score = Level * 1000, Moves = 20 - (Level/2)
        let target = levelIndex * 1000
        let moves = max(10, 25 - levelIndex)
        self.level = Level(targetScore: target, moveLimit: moves)
    }

    func startGame() {
        let _ = level.shuffle()
        score = 0
        movesLeft = level.moveLimit
        delegate?.onGameStarted()
        // Determine if initial matches exist? (Shuffle usually prevents this)
    }

    // MARK: - Dimensions

    var numColumns: Int { return AppConstants.Game.columns }
    var numRows: Int { return AppConstants.Game.rows }

    func itemAt(col: Int, row: Int) -> GameItem? {
        return level.itemAt(column: col, row: row)
    }

    // MARK: - Input

    func didSelectItem(at col: Int, row: Int) {
        guard !isProcessing else { return }
        guard let item = level.itemAt(column: col, row: row) else { return }

        if let first = selectedItem {
            // Second selection
            if isAdjacent(first, item) {
                // Try Swap
                attemptSwap(from: first, to: item)
                selectedItem = nil  // Deselect
            } else {
                // Select new item
                selectedItem = item
                // Notify UI to highlight?
            }
        } else {
            // First selection
            selectedItem = item
            // Notify UI highlight
        }
    }

    private func isAdjacent(_ a: GameItem, _ b: GameItem) -> Bool {
        let dc = abs(a.column - b.column)
        let dr = abs(a.row - b.row)
        return (dc == 1 && dr == 0) || (dc == 0 && dr == 1)
    }

    // MARK: - Logic Loop

    private func attemptSwap(from: GameItem, to: GameItem) {
        // Optimistic UI could happen here

        if engine.isSwapValid(level: level, from: from, to: to) {
            // Valid Swap
            isProcessing = true
            movesLeft -= 1

            level.performSwap(itemA: from, itemB: to)

            // Start chain reaction loop
            handleMatches()

        } else {
            // Invalid
            delegate?.onInvalidSwap(from: from, to: to)
        }
    }

    private func handleMatches() {
        // 1. Detect Matches
        let matches = engine.detectMatches(in: level)

        if matches.isEmpty {
            isProcessing = false
            checkEndGame()
            return
        }

        // 2. Score
        score += matches.count * 10

        // 3. Remove Matches
        engine.removeMatches(matches, from: level)

        // 4. Gravity & New Items
        // This 'applyGravity' returns which columns had new items added
        // But for UI, we need to know exactly which items moved where.
        // For simplicity in this tech demo, we might just "Refresh" the grid or
        // provide the new state to the View and let it compare diffs or just animate purely based on state.
        // But let's use the return value for basics.

        let newItems = engine.fillHoles(in: level)  // returns [[GameItem]] newly created

        // Notify UI to animate Match Destruction -> Fall -> New Items
        // We pass 'matches' to explode, and then we tell UI to refresh from model

        delegate?.onGridUpdated(removed: matches, newItems: newItems, shifted: [])

        // Recursive check after animation delay
        // In a real game, we'd wait for animation callback.
        // Here, we simulate delay or chain call.

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
            self?.handleMatches()
        }
    }

    private func checkEndGame() {
        if movesLeft <= 0 {
            if score >= level.targetScore {
                // Win
                StorageService.shared.saveHighScore(score)
                delegate?.onGameOver(isWin: true)
            } else {
                // Lose
                delegate?.onGameOver(isWin: false)
            }
        }
    }
}
