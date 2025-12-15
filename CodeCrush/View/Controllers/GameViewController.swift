import UIKit

class GameViewController: UIViewController {

    private let viewModel: GameViewModel

    // UI
    private let gridView = GridView()
    private let scoreLabel = UILabel()
    private let movesLabel = UILabel()

    init(levelIndex: Int = 1) {
        self.viewModel = GameViewModel(levelIndex: levelIndex)
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.startGame()
    }

    private func setupUI() {
        view.backgroundColor = AppConstants.Colors.background

        // Stats Bar
        let stack = UIStackView(arrangedSubviews: [movesLabel, scoreLabel])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20

        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stack.heightAnchor.constraint(equalToConstant: 50),
        ])

        // Grid
        view.addSubview(gridView)
        gridView.delegate = self
        gridView.translatesAutoresizingMaskIntoConstraints = false

        // Keep Grid Square and Centered
        NSLayoutConstraint.activate([
            gridView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gridView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            gridView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            gridView.heightAnchor.constraint(equalTo: gridView.widthAnchor, constant: 20),  // Slight adjustment for spacing
        ])

        // Styling
        scoreLabel.textColor = AppConstants.Colors.primaryText
        scoreLabel.font = AppConstants.Fonts.codeDisplay(size: 20)
        scoreLabel.textAlignment = .right

        movesLabel.textColor = AppConstants.Colors.accent
        movesLabel.font = AppConstants.Fonts.codeDisplay(size: 20)
        movesLabel.textAlignment = .left

        updateStats(score: 0, moves: 20)
    }

    private func updateStats(score: Int, moves: Int) {
        scoreLabel.text = "SCORE: \(score)"
        movesLabel.text = "MOVES: \(moves)"
    }

    // Initial Board Population
    private func populateGrid() {
        for col in 0..<viewModel.numColumns {
            for row in 0..<viewModel.numRows {
                if let item = viewModel.itemAt(col: col, row: row) {
                    gridView.createItemView(item: item)
                }
            }
        }
    }
}

// MARK: - ViewModel Delegate
extension GameViewController: GameViewModelDelegate {

    func onGameStarted() {
        populateGrid()
        updateStats(score: viewModel.score, moves: viewModel.movesLeft)
    }

    func onScoreUpdated(newScore: Int) {
        // Simple animation for score
        scoreLabel.text = "SCORE: \(newScore)"
        UIView.animate(
            withDuration: 0.1,
            animations: {
                self.scoreLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }
        ) { _ in
            UIView.animate(withDuration: 0.1) {
                self.scoreLabel.transform = .identity
            }
        }
    }

    func onMoveLimitUpdated(movesLeft: Int) {
        movesLabel.text = "MOVES: \(movesLeft)"
    }

    func onGridUpdated(removed: Set<GameItem>, newItems: [[GameItem]], shifted: [[GameItem]]) {
        // 1. Remove Matches
        for item in removed {
            gridView.removeItemView(col: item.column, row: item.row)
        }

        // 2. Animate Shifts (Simplified: Refresh for now, or TODO: detailed constraints anim)
        // For 'Code Crush' MVP, we will refresh specific items or entire grid after delay if shifts complex.
        // But better: Create new items.

        // Logic: The 'removed' ones are gone. Gravity has happened in Model.
        // The View needs to reflect that.
        // Since we didn't implement complex constraint shifts in GridView yet,
        // We will repurpose views or just re-populate the grid for robustness in MVP.
        // ideally we animate frame moves.

        // For high quality Polish:
        // We would map old items to new positions.
        // But 'newItems' in delegate are newly spawned.

        // "Lazy" MVP Refill:
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            // Re-populate everything to SNAP to new state (including gravity)
            // This sacrifices the "Fall" animation but guarantees valid state.
            // If user wants "Animations" we need more complex binding.
            // Let's at least animate the NEW items dropping in.

            self?.populateGrid()
        }
    }

    func onGameOver(isWin: Bool) {
        let title = isWin ? "COMPILE SUCCESS!" : "BUILD FAILED"
        let msg = isWin ? "Ship it!" : "Try again?"

        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "Restart", style: .default,
                handler: { _ in
                    self.viewModel.startGame()
                }))
        present(alert, animated: true)
    }

    func onInvalidSwap(from: GameItem, to: GameItem) {
        gridView.animateInvalidSwap(from: (from.column, from.row), to: (to.column, to.row))
    }
}

// MARK: - GridView Delegate
extension GameViewController: GridViewDelegate {
    func didTouchItem(at col: Int, row: Int) {
        viewModel.didSelectItem(at: col, row: row)
    }
}
