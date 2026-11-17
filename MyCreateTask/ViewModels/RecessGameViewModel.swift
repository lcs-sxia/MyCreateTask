import Foundation
import Observation

@Observable
final class RecessGameViewModel {

    // MARK: - Stored properties

    let allRecessGames: [RecessGame] = RecessGame.sampleGames
    var playerCount: Int = 3
    private(set) var selectedCategory: String?

    // MARK: - Computed properties

    var categories: [String] {
        var gameCategories: [String] = ["All"]

        for game in allRecessGames {
            if !gameCategories.contains(game.category) {
                gameCategories.append(game.category)
            }
        }

        return gameCategories
    }

    var filteredGames: [RecessGame] {
        var matchingGames: [RecessGame] = []

        for game in allRecessGames {
            let matchesPlayers: Bool = playerCount >= game.minPlayers
            let matchesCategory: Bool = selectedCategory == nil ||
                game.category == selectedCategory

            if matchesPlayers && matchesCategory {
                matchingGames.append(game)
            }
        }

        return matchingGames
    }

    // MARK: - Functions

    func selectCategory(_ category: String) {
        if category == "All" {
            selectedCategory = nil
        } else {
            selectedCategory = category
        }
    }
}
