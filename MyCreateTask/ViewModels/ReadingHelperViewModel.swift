import Foundation
import Observation

@Observable
final class ReadingHelperViewModel {

    // MARK: - Stored properties

    let readingItems: [ReadingItem] = ReadingItem.sampleItems
    var selectedType: ReadingItemType = .vocabulary
    private(set) var revealedVocabularyIDs: Set<UUID> = []
    private(set) var readPassageIDs: Set<UUID> = []
    private(set) var selectedAnswers: [UUID: String] = [:]

    // MARK: - Computed properties

    var vocabularyItems: [ReadingItem] {
        items(ofType: .vocabulary)
    }

    var passageItems: [ReadingItem] {
        items(ofType: .passage)
    }

    var readPassageCount: Int {
        readPassageIDs.count
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

    func markPassageAsRead(_ item: ReadingItem) {
        readPassageIDs.insert(item.id)
    }

    func isPassageRead(_ item: ReadingItem) -> Bool {
        readPassageIDs.contains(item.id)
    }

    func submitAnswer(_ answer: String, for item: ReadingItem) {
        selectedAnswers[item.id] = answer
    }

    func selectedAnswer(for item: ReadingItem) -> String {
        selectedAnswers[item.id, default: ""]
    }

    func isAnswerCorrect(for item: ReadingItem) -> Bool {
        guard let answer = item.answer else {
            return false
        }

        return selectedAnswer(for: item)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .localizedCaseInsensitiveCompare(answer) == .orderedSame
    }

    private func items(ofType type: ReadingItemType) -> [ReadingItem] {
        var matchingItems: [ReadingItem] = []

        for item in readingItems {
            if item.type == type {
                matchingItems.append(item)
            }
        }

        return matchingItems
    }
}
