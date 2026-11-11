import Foundation
import Observation

@Observable
class RecessGameViewModel {

    // MARK: - Stored properties

    let allRecessGames: [RecessGame] = RecessGame.sampleGames

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
