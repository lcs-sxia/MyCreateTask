import Foundation
import Observation

@Observable
class RecessGameViewModel {

    // MARK: - Stored properties

    let allRecessGames: [RecessGame] = [
        RecessGame(
            name: "Four Square",
            minPlayers: 4,
            equipment: "Four-square court and ball"
        ),
        RecessGame(
            name: "Tag",
            minPlayers: 2,
            equipment: "Open playground space"
        ),
        RecessGame(
            name: "Soccer",
            minPlayers: 4,
            equipment: "Ball and two goals"
        ),
        RecessGame(
            name: "Jump Rope Challenge",
            minPlayers: 1,
            equipment: "Jump rope"
        ),
        RecessGame(
            name: "Capture the Flag",
            minPlayers: 6,
            equipment: "Two flags and open playground space"
        )
    ]

    // MARK: - Functions

    // AP procedure: iteration and selection find games for a group.
    func findGamesForGroup(playerCount: Int) -> [RecessGame] {
        var matchingGames: [RecessGame] = []

        for game in allRecessGames {
            if playerCount >= game.minPlayers {
                matchingGames.append(game)
            }
        }

        return matchingGames
    }
}
