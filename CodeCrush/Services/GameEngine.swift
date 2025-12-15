import Foundation

struct Match: Hashable {
    let items: Set<GameItem>
    let matchType: MatchType
}

enum MatchType {
    case horizontal
    case vertical
    // case TShape, LShape (Future improvements)
}

class GameEngine {

    // MARK: - Match Detection

    func detectMatches(in level: Level) -> Set<GameItem> {
        var set: Set<GameItem> = []

        // Horizontal Matches
        for row in 0..<AppConstants.Game.rows {
            var column = 0
            while column < AppConstants.Game.columns - 2 {
                if let item = level.itemAt(column: column, row: row) {
                    let matchType = item.itemType

                    if let itemNext = level.itemAt(column: column + 1, row: row),
                        let itemNext2 = level.itemAt(column: column + 2, row: row),
                        itemNext.itemType == matchType,
                        itemNext2.itemType == matchType
                    {

                        set.insert(item)
                        set.insert(itemNext)
                        set.insert(itemNext2)

                        // Check for >3 match
                        var nextCol = column + 3
                        while nextCol < AppConstants.Game.columns {
                            if let nextItem = level.itemAt(column: nextCol, row: row),
                                nextItem.itemType == matchType
                            {
                                set.insert(nextItem)
                                nextCol += 1
                            } else {
                                break
                            }
                        }

                        // Continue search
                        column = nextCol
                        continue
                    }
                }
                column += 1
            }
        }

        // Vertical Matches
        for col in 0..<AppConstants.Game.columns {
            var row = 0
            while row < AppConstants.Game.rows - 2 {
                if let item = level.itemAt(column: col, row: row) {
                    let matchType = item.itemType

                    if let itemNext = level.itemAt(column: col, row: row + 1),
                        let itemNext2 = level.itemAt(column: col, row: row + 2),
                        itemNext.itemType == matchType,
                        itemNext2.itemType == matchType
                    {

                        set.insert(item)
                        set.insert(itemNext)
                        set.insert(itemNext2)

                        // Check for >3
                        var nextRow = row + 3
                        while nextRow < AppConstants.Game.rows {
                            if let nextItem = level.itemAt(column: col, row: nextRow),
                                nextItem.itemType == matchType
                            {
                                set.insert(nextItem)
                                nextRow += 1
                            } else {
                                break
                            }
                        }

                        row = nextRow
                        continue
                    }
                }
                row += 1
            }
        }

        return set
    }

    // MARK: - Game Loop Operations

    func removeMatches(_ matches: Set<GameItem>, from level: Level) {
        for item in matches {
            level.setItem(nil, at: item.column, row: item.row)
        }
    }

    func fillHoles(in level: Level) -> [[GameItem]] {
        // We rely on 'applyGravity' to repack the columns and fill the top with new items.
        // This handles the correct "falling" mechanic where items move to higher row indices.
        return applyGravity(in: level)
    }

    // Simpler Gravity Implementation
    // Returns columns of NEW items created (for animation)
    private func applyGravity(in level: Level) -> [[GameItem]] {
        var newItemsAllCols: [[GameItem]] = []

        for col in 0..<AppConstants.Game.columns {
            var newItems: [GameItem] = []

            // 1. Shift down
            // Collect all existing types in this col
            var existingItems: [GameItem] = []
            for row in 0..<AppConstants.Game.rows {
                if let item = level.itemAt(column: col, row: row) {
                    existingItems.append(item)
                }
            }

            // In UIKit, (0,0) is Top-Left.
            // Row 0 is the Top. Row 7 is either Bottom.
            // Gravity means items accumulate at the Bottom (Higher Row Index).

            // We repack existing items to the bottom indices.

            // Traverse from bottom (Row 7) to top (Row 0)
            // But easier: Get list of items, filtering nils.
            // If we have 5 items, they should occupy rows 7, 6, 5, 4, 3. (Bottom 5).

            let missingCount = AppConstants.Game.rows - existingItems.count

            // Clear entire column
            for row in 0..<AppConstants.Game.rows {
                level.setItem(nil, at: col, row: row)
            }

            // Put existing items at bottom (Highest row index)
            // existingItems was collected from Top (0) to Bottom (7). Order is preserved.
            // We want them at the bottom.
            // Wait, if (0,0) is TOP, then existing items should slide to BOTTOM (Max Row).

            var currentRow = AppConstants.Game.rows - 1
            for item in existingItems.reversed() {  // Start with bottom-most original item
                var movedItem = item
                movedItem.row = currentRow
                level.setItem(movedItem, at: col, row: currentRow)
                currentRow -= 1
            }

            // Fill top 'missingCount' rows with NEW items
            for i in 0..<missingCount {
                let row = missingCount - 1 - i  // 0, 1, 2...
                let newItemType = ItemType.random()
                let newItem = GameItem(column: col, row: row, itemType: newItemType)
                level.setItem(newItem, at: col, row: row)
                newItems.append(newItem)
            }

            newItemsAllCols.append(newItems)
        }

        return newItemsAllCols
    }

    // Check if swap is valid (results in match)
    func isSwapValid(level: Level, from: GameItem, to: GameItem) -> Bool {
        // Perform temporary swap
        level.performSwap(itemA: from, itemB: to)

        let matches = detectMatches(in: level)

        // Swap back
        level.performSwap(itemA: from, itemB: to)  // (Swap is its own inverse)

        return !matches.isEmpty
    }
}
