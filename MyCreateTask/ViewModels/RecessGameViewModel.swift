//
//  RecessGameViewModel.swift
//  MyCreateTask
//
//  Created by Steven Xia on 2026-11-10.
//  This code was generated using GitHub Copilot.
//

import Foundation
import Observation

enum RecessPlayerFilter: String, CaseIterable, Identifiable {
    case any = "Any"
    case small = "2–4 Players"
    case medium = "5–8 Players"
    case large = "8+ Players"

    var id: String {
        rawValue
    }
}

@Observable
final class RecessGameViewModel {

    // MARK: - Stored properties

    let allRecessGames: [RecessGame] = RecessGame.sampleGames
    var selectedPlayerFilter: RecessPlayerFilter = .any
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
        filterRecessGames(
            games: allRecessGames,
            playerFilter: selectedPlayerFilter,
            category: selectedCategory
        )
    }

    // MARK: - Functions

    func selectCategory(_ category: String) {
        if category == "All" {
            selectedCategory = nil
        } else {
            selectedCategory = category
        }
    }

    func filterRecessGames(
        games: [RecessGame],
        playerFilter: RecessPlayerFilter,
        category: String?
    ) -> [RecessGame] {
        var matchingGames: [RecessGame] = []

        // Check every recess game against the selected player and category filters.
        for game in games {
            let matchesPlayers: Bool = recessGameMatches(
                game: game,
                playerFilter: playerFilter
            )

            var matchesCategory: Bool = false
            if category == nil {
                matchesCategory = true
            } else if game.category == category {
                matchesCategory = true
            }

            if matchesPlayers && matchesCategory {
                matchingGames.append(game)
            }
        }

        return matchingGames
    }

    private func recessGameMatches(
        game: RecessGame,
        playerFilter: RecessPlayerFilter
    ) -> Bool {
        switch playerFilter {
        case .any:
            return true
        case .small:
            if game.minPlayers <= 4 && game.maxPlayers >= 2 {
                return true
            } else {
                return false
            }
        case .medium:
            if game.minPlayers <= 8 && game.maxPlayers >= 5 {
                return true
            } else {
                return false
            }
        case .large:
            if game.maxPlayers >= 8 {
                return true
            } else {
                return false
            }
        }
    }
}
