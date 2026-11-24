//
//  ReadingHelperViewModel.swift
//  MyCreateTask
//
//  Created by Steven Xia on 2026-11-11.
//  This code was generated using GitHub Copilot.
//

import Foundation
import Observation

enum ReadingLevelFilter: String, CaseIterable, Identifiable {
    case all = "All Levels"
    case level1 = "Level 1"
    case level2 = "Level 2"
    case level3 = "Level 3"

    var id: String {
        rawValue
    }

    var level: Int? {
        switch self {
        case .all:
            return nil
        case .level1:
            return 1
        case .level2:
            return 2
        case .level3:
            return 3
        }
    }
}
 
enum ReadingTimeFilter: String, CaseIterable, Identifiable {
    case all = "All Times"
    case short = "2–3 min"
    case medium = "4–5 min"

    var id: String {
        rawValue
    }

    func matches(_ readingTime: Int) -> Bool {
        switch self {
        case .all:
            return true
        case .short:
            return readingTime >= 2 && readingTime <= 3
        case .medium:
            return readingTime >= 4 && readingTime <= 5
        }
    }
}

@Observable
final class ReadingHelperViewModel {

    // MARK: - Stored properties

    // This list is the source of truth for all vocabulary words and passages.
    private let readingItems: [ReadingItem] = ReadingItem.sampleItems
    var selectedType: ReadingItemType = .vocabulary
    var selectedPartOfSpeech: ReadingPartOfSpeech?
    var selectedPassageCategory: String?
    var selectedPassageLevel: ReadingLevelFilter = .all
    var selectedPassageTime: ReadingTimeFilter = .all
    // These sets remember which cards have been revealed or mastered.
    private(set) var revealedVocabularyIDs: Set<UUID> = []
    private(set) var masteredVocabularyIDs: Set<UUID> = []

    // MARK: - Computed properties

    var vocabularyItems: [ReadingItem] {
        // Send the saved filters to the clear loop-based filtering function.
        filterVocabulary(
            readingItems: readingItems,
            selectedPartOfSpeech: selectedPartOfSpeech
        )
    }

    var passageItems: [ReadingItem] {
        // Send the saved category, level, and time choices to the passage filter.
        filterPassages(
            readingItems: readingItems,
            category: selectedPassageCategory,
            level: selectedPassageLevel.level,
            timeRange: selectedPassageTime
        )
    }

    var masteredVocabularyCount: Int {
        countMasteredVocabulary(
            readingItems: readingItems,
            masteredVocabularyIDs: masteredVocabularyIDs
        )
    }

    var totalVocabularyCount: Int {
        countVocabularyItems(readingItems: readingItems)
    }

    // MARK: - Functions

    func toggleVocabularyReveal(_ item: ReadingItem) {
        if revealedVocabularyIDs.contains(item.id) {
            revealedVocabularyIDs.remove(item.id)
        } else {
            revealedVocabularyIDs.insert(item.id)
        }
    }

    func isVocabularyRevealed(_ item: ReadingItem) -> Bool {
        revealedVocabularyIDs.contains(item.id)
    }

    func revealVocabulary(_ item: ReadingItem) {
        revealedVocabularyIDs.insert(item.id)
    }

    func toggleVocabularyMastered(_ item: ReadingItem) {
        if masteredVocabularyIDs.contains(item.id) {
            masteredVocabularyIDs.remove(item.id)
        } else {
            masteredVocabularyIDs.insert(item.id)
        }
    }

    func isVocabularyMastered(_ item: ReadingItem) -> Bool {
        masteredVocabularyIDs.contains(item.id)
    }

    // MARK: - Helper functions

    private func filterVocabulary(
        readingItems: [ReadingItem],
        selectedPartOfSpeech: ReadingPartOfSpeech?
    ) -> [ReadingItem] {
        var matchingItems: [ReadingItem] = []

        // Check each reading item one at a time.
        for item in readingItems {
            if item.type != .vocabulary {
                continue
            }

            // A nil part of speech means that All is selected.
            if selectedPartOfSpeech == nil {
                matchingItems.append(item)
            } else if item.partOfSpeech == selectedPartOfSpeech {
                matchingItems.append(item)
            }
        }

        return matchingItems
    }

    func filterPassages(
        readingItems: [ReadingItem],
        category: String?,
        level: Int?,
        timeRange: ReadingTimeFilter
    ) -> [ReadingItem] {
        var matchingItems: [ReadingItem] = []

        // Check every reading item against the three saved passage filters.
        for item in readingItems {
            if item.type != .passage {
                continue
            }

            if category != nil {
                if item.category != category {
                    continue
                }
            }

            if level != nil {
                if item.readingLevel != level {
                    continue
                }
            }

            let readingTime: Int = item.readingTime ?? 0
            if timeRange.matches(readingTime) {
                matchingItems.append(item)
            }
        }

        return matchingItems
    }

    private func countVocabularyItems(readingItems: [ReadingItem]) -> Int {
        var count: Int = 0

        // Count vocabulary items only, so the interface has an accurate total.
        for item in readingItems {
            if item.type == .vocabulary {
                count += 1
            }
        }

        return count
    }

    private func countMasteredVocabulary(
        readingItems: [ReadingItem],
        masteredVocabularyIDs: Set<UUID>
    ) -> Int {
        var count: Int = 0

        // Count only vocabulary cards that the student marked mastered.
        for item in readingItems {
            if item.type == .vocabulary {
                if masteredVocabularyIDs.contains(item.id) {
                    count += 1
                }
            }
        }

        return count
    }
}
