import Foundation
import Observation

@Observable
final class LearningAssistantViewModel {

    // MARK: - Stored properties

    let allQuestions: [LearningQuestion] = LearningQuestion.sampleQuestions

    private(set) var score: Int = 0
    private(set) var currentQuestionIndices: [LearningSubject: Int] = [:]

    private var completedQuestionIDs: Set<UUID> = []
    private var selectedAnswers: [UUID: String] = [:]

    // MARK: - Initializer

    init() {
        for subject in LearningSubject.allCases {
            currentQuestionIndices[subject] = 0
        }
    }

    // MARK: - Functions

    func questions(for subject: LearningSubject) -> [LearningQuestion] {
        var matchingQuestions: [LearningQuestion] = []

        for question in allQuestions {
            if question.subject == subject {
                matchingQuestions.append(question)
            }
        }

        return matchingQuestions
    }

    func currentQuestion(for subject: LearningSubject) -> LearningQuestion? {
        let subjectQuestions: [LearningQuestion] = questions(for: subject)
        let currentIndex: Int = currentQuestionIndices[subject, default: 0]

        guard subjectQuestions.indices.contains(currentIndex) else {
            return nil
        }

        return subjectQuestions[currentIndex]
    }

    func nextQuestion(for subject: LearningSubject) {
        let subjectQuestions: [LearningQuestion] = questions(for: subject)

        guard !subjectQuestions.isEmpty else {
            return
        }

        let currentIndex: Int = currentQuestionIndices[subject, default: 0]
        let nextIndex: Int = (currentIndex + 1) % subjectQuestions.count
        currentQuestionIndices[subject] = nextIndex

        let nextQuestionID: UUID = subjectQuestions[nextIndex].id
        selectedAnswers.removeValue(forKey: nextQuestionID)
    }

    func selectedAnswer(for question: LearningQuestion) -> String? {
        selectedAnswers[question.id]
    }

    @discardableResult
    func submit(answer: String, for question: LearningQuestion) -> Bool {
        selectedAnswers[question.id] = answer

        let normalizedAnswer: String = normalize(answer, for: question)
        let normalizedCorrectAnswer: String = normalize(
            question.correctAnswer,
            for: question
        )
        let isCorrect: Bool = normalizedAnswer == normalizedCorrectAnswer

        if isCorrect && !completedQuestionIDs.contains(question.id) {
            completedQuestionIDs.insert(question.id)
            score += 10
        }

        return isCorrect
    }

    func isCorrect(answer: String?, for question: LearningQuestion) -> Bool {
        guard let answer else {
            return false
        }

        return normalize(answer, for: question) == normalize(
            question.correctAnswer,
            for: question
        )
    }

    private func normalize(_ answer: String, for question: LearningQuestion) -> String {
        let trimmedAnswer: String = answer.trimmingCharacters(in: .whitespacesAndNewlines)

        if question.subject == .math {
            return trimmedAnswer
                .replacingOccurrences(of: ",", with: "")
                .replacingOccurrences(of: " ", with: "")
        }

        return trimmedAnswer
    }
}
