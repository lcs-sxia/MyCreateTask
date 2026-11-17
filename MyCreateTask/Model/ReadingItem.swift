import Foundation

enum ReadingItemType: String, CaseIterable, Identifiable {
    case vocabulary = "Vocabulary"
    case passage = "Reading Passages"

    var id: String {
        rawValue
    }
}

struct ReadingItem: Identifiable, Hashable {

    // MARK: - Stored properties

    let id: UUID
    let type: ReadingItemType
    let title: String
    let partOfSpeech: String?
    let definition: String?
    let exampleSentence: String?
    let passage: String?
    let question: String?
    let answer: String?

    // MARK: - Initializer

    init(
        id: UUID = UUID(),
        type: ReadingItemType,
        title: String,
        partOfSpeech: String? = nil,
        definition: String? = nil,
        exampleSentence: String? = nil,
        passage: String? = nil,
        question: String? = nil,
        answer: String? = nil
    ) {
        self.id = id
        self.type = type
        self.title = title
        self.partOfSpeech = partOfSpeech
        self.definition = definition
        self.exampleSentence = exampleSentence
        self.passage = passage
        self.question = question
        self.answer = answer
    }
}

extension ReadingItem {

    // MARK: - Sample data

    static let sampleItems: [ReadingItem] = [
        ReadingItem(
            type: .vocabulary,
            title: "Curious",
            partOfSpeech: "adjective",
            definition: "Wanting to learn or know more about something.",
            exampleSentence: "Maya was curious about how volcanoes erupt."
        ),
        ReadingItem(
            type: .vocabulary,
            title: "Observe",
            partOfSpeech: "verb",
            definition: "To watch carefully and notice details.",
            exampleSentence: "Scientists observe animals to learn about their habits."
        ),
        ReadingItem(
            type: .vocabulary,
            title: "Resourceful",
            partOfSpeech: "adjective",
            definition: "Good at finding clever ways to solve a problem.",
            exampleSentence: "The resourceful team built a bridge from cardboard."
        ),
        ReadingItem(
            type: .passage,
            title: "The School Garden",
            passage: "Every Friday, the class visits its school garden. Students measure the plants, pull weeds, and record which vegetables are growing fastest. They have learned that sunlight, water, and healthy soil help plants thrive.",
            question: "What three things help the garden plants thrive?",
            answer: "Sunlight, water, and healthy soil."
        ),
        ReadingItem(
            type: .passage,
            title: "A Clever Octopus",
            passage: "An octopus can change the color and texture of its skin to blend into its surroundings. This skill helps it hide from predators and sneak up on food. Some octopuses can even use shells as protection.",
            question: "How does changing its appearance help an octopus?",
            answer: "It helps the octopus hide and find food."
        )
    ]
}
