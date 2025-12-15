import Foundation

class StorageService {
    static let shared = StorageService()

    private let kHighScore = "kCodeCrushHighScore"

    func getHighScore() -> Int {
        return UserDefaults.standard.integer(forKey: kHighScore)
    }

    func saveHighScore(_ score: Int) {
        let current = getHighScore()
        if score > current {
            UserDefaults.standard.set(score, forKey: kHighScore)
        }
    }
}
