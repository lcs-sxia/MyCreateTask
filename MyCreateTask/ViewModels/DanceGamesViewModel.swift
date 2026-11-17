import Foundation
import Observation

@Observable
final class DanceGamesViewModel {

    // MARK: - Stored properties

    let games: [DanceGame] = DanceGame.sampleGames
    var selectedCategory: DanceGameCategory?
    var selectedEnergy: DanceGameEnergy?
    private(set) var secondsRemaining: Int = 0
    private(set) var isTimerRunning: Bool = false
    private(set) var selectedGameID: UUID?

    // MARK: - Computed properties

    var filteredGames: [DanceGame] {
        var matchingGames: [DanceGame] = []

        for game in games {
            let matchesCategory: Bool = selectedCategory == nil || game.category == selectedCategory
            let matchesEnergy: Bool = selectedEnergy == nil || game.energy == selectedEnergy

            if matchesCategory && matchesEnergy {
                matchingGames.append(game)
            }
        }

        return matchingGames
    }

    var timerText: String {
        let minutes: Int = secondsRemaining / 60
        let seconds: Int = secondsRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    // MARK: - Functions

    func selectGame(_ game: DanceGame) {
        selectedGameID = game.id
        secondsRemaining = game.duration
        isTimerRunning = false
    }

    func startTimer() {
        guard secondsRemaining > 0 else {
            return
        }

        isTimerRunning = true
    }

    func pauseTimer() {
        isTimerRunning = false
    }

    func resetTimer() {
        guard let selectedGameID,
              let selectedGame = game(withID: selectedGameID) else {
            secondsRemaining = 0
            isTimerRunning = false
            return
        }

        secondsRemaining = selectedGame.duration
        isTimerRunning = false
    }

    func tickTimer() {
        guard isTimerRunning else {
            return
        }

        if secondsRemaining > 0 {
            secondsRemaining -= 1
        }

        if secondsRemaining == 0 {
            isTimerRunning = false
        }
    }

    private func game(withID id: UUID) -> DanceGame? {
        for game in games {
            if game.id == id {
                return game
            }
        }

        return nil
    }
}
