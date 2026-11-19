import Foundation
import Observation

@Observable
final class ReadingHelperViewModel {

    // MARK: - Stored properties

    let readingItems: [ReadingItem] = ReadingItem.sampleItems
    var selectedType: ReadingItemType = .vocabulary
    var selectedPartOfSpeech: ReadingPartOfSpeech?
    var selectedPassageCategory: String?
    private(set) var revealedVocabularyIDs: Set<UUID> = []
    private(set) var masteredVocabularyIDs: Set<UUID> = []

    // MARK: - Computed properties

    var vocabularyItems: [ReadingItem] {
        var matchingItems: [ReadingItem] = []

        for item in readingItems {
            guard item.type == .vocabulary else {
                continue
            }

            if selectedPartOfSpeech == nil || item.partOfSpeech == selectedPartOfSpeech {
                matchingItems.append(item)
            }
        }

        return matchingItems
    }

    var passageItems: [ReadingItem] {
        var matchingItems: [ReadingItem] = []

        for item in readingItems {
            guard item.type == .passage else {
                continue
            }

            if selectedPassageCategory == nil || item.category == selectedPassageCategory {
                matchingItems.append(item)
            }
        }

        return matchingItems
    }

    var masteredVocabularyCount: Int {
        masteredVocabularyIDs.count
    }

    var totalVocabularyCount: Int {
        var count = 0

        for item in readingItems {
            if item.type == .vocabulary {
                count += 1
            }
        }

        return count
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
}
