//
//  DanceGamesViewModel.swift
//  MyCreateTask
//
//  Created by Steven Xia on 2026-11-11.
//  This code was generated using GitHub Copilot.
//

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
    private(set) var remainingSecondsByGame: [UUID: Int] = [:]
    private(set) var runningGameIDs: Set<UUID> = []
    private(set) var completedGameIDs: Set<UUID> = []

    // MARK: - Initializer

    init() {
        for game in games {
            remainingSecondsByGame[game.id] = game.duration
        }
    }

    // MARK: - Computed properties

    var filteredGames: [DanceGame] {
        filterDanceGames(
            games: games,
            category: selectedCategory,
            energy: selectedEnergy
        )
    }

    var timerText: String {
        let minutes: Int = secondsRemaining / 60
        let seconds: Int = secondsRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    // MARK: - Functions

    func remainingSeconds(for game: DanceGame) -> Int {
        remainingSecondsByGame[game.id] ?? game.duration
    }

    func timerText(for game: DanceGame) -> String {
        let secondsRemaining = remainingSeconds(for: game)
        let minutes: Int = secondsRemaining / 60
        let seconds: Int = secondsRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func isRunning(_ game: DanceGame) -> Bool {
        runningGameIDs.contains(game.id)
    }

    func isComplete(_ game: DanceGame) -> Bool {
        completedGameIDs.contains(game.id)
    }

    func startTimer(for game: DanceGame) {
        if isComplete(game) {
            remainingSecondsByGame[game.id] = game.duration
            completedGameIDs.remove(game.id)
        }

        if remainingSecondsByGame[game.id] == nil {
            remainingSecondsByGame[game.id] = game.duration
        }

        guard remainingSeconds(for: game) > 0 else {
            return
        }

        runningGameIDs.insert(game.id)
    }

    func pauseTimer(for game: DanceGame) {
        runningGameIDs.remove(game.id)
    }

    func resetTimer(for game: DanceGame) {
        remainingSecondsByGame[game.id] = game.duration
        runningGameIDs.remove(game.id)
        completedGameIDs.remove(game.id)
    }

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
        for game in games {
            guard runningGameIDs.contains(game.id) else {
                continue
            }

            let remainingSeconds = remainingSeconds(for: game)
            if remainingSeconds > 0 {
                remainingSecondsByGame[game.id] = remainingSeconds - 1
            }

            if remainingSeconds <= 1 {
                runningGameIDs.remove(game.id)
                completedGameIDs.insert(game.id)
            }
        }

        if isTimerRunning {
            if secondsRemaining > 0 {
                secondsRemaining -= 1
            }
            if secondsRemaining == 0 {
                isTimerRunning = false
            }
        }
    }

    func filterDanceGames(
        games: [DanceGame],
        category: DanceGameCategory?,
        energy: DanceGameEnergy?
    ) -> [DanceGame] {
        var matchingGames: [DanceGame] = []

        // Check each activity against both of the saved filters.
        for game in games {
            var matchesCategory: Bool = false
            if category == nil {
                matchesCategory = true
            } else if game.category == category {
                matchesCategory = true
            }

            var matchesEnergy: Bool = false
            if energy == nil {
                matchesEnergy = true
            } else if game.energy == energy {
                matchesEnergy = true
            }

            if matchesCategory && matchesEnergy {
                matchingGames.append(game)
            }
        }

        return matchingGames
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
