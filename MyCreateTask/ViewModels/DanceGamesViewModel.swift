import Foundation
import Observation

@Observable
final class DanceGamesViewModel {

    // MARK: - Stored properties

    let games: [DanceGame] = DanceGame.sampleGames
}
