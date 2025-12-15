import UIKit

struct AppConstants {

    struct Colors {
        // Dark Mode Palette
        static let background = UIColor(hex: "#121212")
        static let surface = UIColor(hex: "#1E1E1E")
        static let surfaceHighlight = UIColor(hex: "#2C2C2C")

        static let primaryText = UIColor(hex: "#FFFFFF")
        static let secondaryText = UIColor(hex: "#AAAAAA")

        static let accent = UIColor(hex: "#BB86FC")  // Purple-ish
        static let niceBlue = UIColor(hex: "#03DAC6")  // Teal-ish (Secondary)
        static let error = UIColor(hex: "#CF6679")
        static let success = UIColor(hex: "#03DAC6")
    }

    struct Fonts {
        static func main(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
            return UIFont.monospacedSystemFont(ofSize: size, weight: weight)
        }

        static func codeDisplay(size: CGFloat) -> UIFont {
            return UIFont(name: "Menlo-Bold", size: size)
                ?? UIFont.systemFont(ofSize: size, weight: .bold)
        }
    }

    struct Game {
        static let defaultMoveLimit = 20
        static let rows = 8
        static let columns = 7  // Slightly narrower for portrait mobile
        static let animationDuration: TimeInterval = 0.25
    }
}
