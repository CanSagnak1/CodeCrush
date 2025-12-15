import Foundation

enum ItemType: Int, CaseIterable {
    case api = 0
    case json, git, swift, bug, sql

    var spriteName: String {
        switch self {
        case .api: return "Chip_API"
        case .json: return "Chip_JSON"
        case .git: return "Chip_GIT"
        case .swift: return "Chip_SWIFT"
        case .bug: return "Chip_BUG"
        case .sql: return "Chip_SQL"
        }
    }

    static func random() -> ItemType {
        return ItemType(rawValue: Int.random(in: 0..<ItemType.allCases.count))!
    }
}

struct GameItem: Hashable, CustomStringConvertible {
    var column: Int
    var row: Int
    let itemType: ItemType

    var description: String {
        return "type:\(itemType) square:(\(column),\(row))"
    }

    // Hashable for Set operations
    func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(column)
    }

    static func == (lhs: GameItem, rhs: GameItem) -> Bool {
        return lhs.column == rhs.column && lhs.row == rhs.row
    }
}
