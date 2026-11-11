import Foundation

enum LearningSubject: String, CaseIterable, Identifiable {
    case math = "Math"
    case science = "Science"
    case socialStudies = "Social Studies"

    var id: String {
        rawValue
    }

    var icon: String {
        switch self {
        case .math:
            "function"
        case .science:
            "atom"
        case .socialStudies:
            "building.columns"
        }
    }
}

struct LearningQuestion: Identifiable, Hashable {

    // MARK: - Stored properties

    let id: UUID
    let subject: LearningSubject
    let questionText: String
    let options: [String]
    let correctAnswer: String
    let hint: String

    // MARK: - Initializer

    init(
        id: UUID = UUID(),
        subject: LearningSubject,
        questionText: String,
        options: [String],
        correctAnswer: String,
        hint: String
    ) {
        self.id = id
        self.subject = subject
        self.questionText = questionText
        self.options = options
        self.correctAnswer = correctAnswer
        self.hint = hint
    }
}

extension LearningQuestion {

    // MARK: - Sample data

    static let sampleQuestions: [LearningQuestion] = [
        LearningQuestion(
            subject: .math,
            questionText: "What is 247 × 6?",
            options: ["1,482", "1,242", "1,522", "1,362"],
            correctAnswer: "1,482",
            hint: "Multiply the ones, tens, and hundreds separately, then add the partial products."
        ),
        LearningQuestion(
            subject: .math,
            questionText: "Which fraction is equivalent to 1/2?",
            options: ["2/4", "2/3", "3/5", "4/6"],
            correctAnswer: "2/4",
            hint: "Multiply the numerator and denominator by the same number."
        ),
        LearningQuestion(
            subject: .science,
            questionText: "What process changes liquid water into water vapor?",
            options: ["Evaporation", "Condensation", "Precipitation", "Collection"],
            correctAnswer: "Evaporation",
            hint: "This happens when the Sun warms water on Earth’s surface."
        ),
        LearningQuestion(
            subject: .science,
            questionText: "Which form of energy helps a lamp produce light?",
            options: ["Electrical energy", "Sound energy", "Chemical energy", "Motion energy"],
            correctAnswer: "Electrical energy",
            hint: "Think about the type of energy carried through the lamp’s cord."
        ),
        LearningQuestion(
            subject: .science,
            questionText: "What happens during condensation?",
            options: ["Gas changes to liquid", "Liquid changes to gas", "Water freezes", "Rain collects"],
            correctAnswer: "Gas changes to liquid",
            hint: "Water droplets form when water vapor cools."
        ),
        LearningQuestion(
            subject: .socialStudies,
            questionText: "Which branch of the U.S. government makes laws?",
            options: ["Legislative", "Executive", "Judicial", "Local"],
            correctAnswer: "Legislative",
            hint: "Congress is part of this branch."
        ),
        LearningQuestion(
            subject: .socialStudies,
            questionText: "What is a landform surrounded by water on three sides?",
            options: ["Peninsula", "Island", "Valley", "Plateau"],
            correctAnswer: "Peninsula",
            hint: "The word starts with “pen,” and it connects to larger land."
        ),
        LearningQuestion(
            subject: .socialStudies,
            questionText: "What is the main purpose of a map legend?",
            options: ["Explain symbols", "Show the weather", "Measure time", "Name every city"],
            correctAnswer: "Explain symbols",
            hint: "Look for the guide that tells you what map markings mean."
        )
    ]
}
