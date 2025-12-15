// File: Level.swift
// Created by: Can Sağnak
// Date: 2025-12-15
// Description: Game level logic and 2D array helper for the game grid.

import Foundation

class Level {
    let targetScore: Int
    let moveLimit: Int

    private var items = Array2D<GameItem>(
        columns: AppConstants.Game.columns, rows: AppConstants.Game.rows)

    init(targetScore: Int = 1000, moveLimit: Int = 20) {
        self.targetScore = targetScore
        self.moveLimit = moveLimit
    }

    func itemAt(column: Int, row: Int) -> GameItem? {
        // Validation check
        guard
            column >= 0 && column < AppConstants.Game.columns && row >= 0
                && row < AppConstants.Game.rows
        else {
            return nil
        }
        return items[column, row]
    }

    func shuffle() -> Set<GameItem> {
        return createInitialItems()
    }

    private func createInitialItems() -> Set<GameItem> {
        var set: Set<GameItem> = []

        // Loop through rows & columns to generate initial types
        // Ensuring no initial matches exist
        for row in 0..<AppConstants.Game.rows {
            for column in 0..<AppConstants.Game.columns {
                var itemType: ItemType

                // Keep picking a random type until we find one that doesn't make a match-3
                repeat {
                    itemType = ItemType.random()
                } while (column >= 2 && items[column - 1, row]?.itemType == itemType
                    && items[column - 2, row]?.itemType == itemType)
                    || (row >= 2 && items[column, row - 1]?.itemType == itemType
                        && items[column, row - 2]?.itemType == itemType)

                let item = GameItem(column: column, row: row, itemType: itemType)
                items[column, row] = item
                set.insert(item)
            }
        }
        return set
    }

    // Perform swapping inside the data model
    func performSwap(itemA: GameItem, itemB: GameItem) {
        items[itemA.column, itemA.row] = itemB
        items[itemB.column, itemB.row] = itemA
    }

    // Reset internal grid slot (used during falling/clearing)
    func checkItem(at column: Int, row: Int) -> GameItem? {
        return items[column, row]
    }

    func setItem(_ item: GameItem?, at column: Int, row: Int) {
        items[column, row] = item
    }
}

// Helper generic 2D Array
struct Array2D<T> {
    let columns: Int
    let rows: Int
    var array: [T?]

    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        array = [T?](repeating: nil, count: rows * columns)
    }

    subscript(column: Int, row: Int) -> T? {
        get {
            return array[row * columns + column]
        }
        set {
            array[row * columns + column] = newValue
        }
    }
}

