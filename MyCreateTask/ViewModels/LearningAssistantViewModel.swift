//
//  LearningAssistantViewModel.swift
//  MyCreateTask
//
//  Created by Steven Xia on 2026-11-11.
//  This code was generated using GitHub Copilot.
//

import Foundation
import Observation

@Observable
final class LearningAssistantViewModel {

    // MARK: - Stored properties

    // These lists hold every question and study concept for the app.
    let allQuestions: [LearningQuestion] = LearningQuestion.sampleQuestions
    let allStudyConcepts: [StudyConcept] = StudyConcept.sampleConcepts

    private(set) var score: Int = 0
    private(set) var currentQuestionIndices: [LearningSubject: Int] = [:]
    private(set) var hasFailedCurrentQuestion: Bool = false
    private(set) var showHint: Bool = false
    private(set) var wrongSelectedOptions: Set<String> = []

    private var completedQuestionIDs: Set<UUID> = []
    private var attemptedIncorrectQuestionIDs: Set<UUID> = []
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

    func studyConcepts(for subject: LearningSubject) -> [StudyConcept] {
        var matchingConcepts: [StudyConcept] = []

        for concept in allStudyConcepts {
            if concept.subject == subject {
                matchingConcepts.append(concept)
            }
        }

        return matchingConcepts
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
        hasFailedCurrentQuestion = false
        showHint = false
        wrongSelectedOptions = []
        selectedAnswers.removeValue(forKey: subjectQuestions[currentIndex].id)

        let nextQuestionID: UUID = subjectQuestions[nextIndex].id
        selectedAnswers.removeValue(forKey: nextQuestionID)
    }

    func resetForSubjectChange() {
        hasFailedCurrentQuestion = false
        showHint = false
        wrongSelectedOptions = []
    }

    func tryAgain(for question: LearningQuestion) {
        selectedAnswers.removeValue(forKey: question.id)
        wrongSelectedOptions = []
        hasFailedCurrentQuestion = false
        showHint = false
    }

    func selectedAnswer(for question: LearningQuestion) -> String? {
        selectedAnswers[question.id]
    }

    @discardableResult
    func submit(answer: String, for question: LearningQuestion) -> Bool {
        selectedAnswers[question.id] = answer

        let normalizedAnswer: String = normalize(answer)
        let normalizedCorrectAnswer: String = normalize(question.correctAnswer)
        let isCorrect: Bool = checkQuizAnswer(
            selectedOption: normalizedAnswer,
            correctOption: normalizedCorrectAnswer
        )

        if !isCorrect {
            hasFailedCurrentQuestion = true
            wrongSelectedOptions.insert(answer)
            attemptedIncorrectQuestionIDs.insert(question.id)
        }

        if isCorrect && !completedQuestionIDs.contains(question.id) {
            completedQuestionIDs.insert(question.id)
            let wasAttemptedIncorrectly: Bool =
                attemptedIncorrectQuestionIDs.contains(question.id)
            score += calculateQuizPoints(wasAttemptedIncorrectly: wasAttemptedIncorrectly)
            hasFailedCurrentQuestion = false
            wrongSelectedOptions = []
        }

        return isCorrect
    }

    func isCorrect(answer: String?, for question: LearningQuestion) -> Bool {
        guard let answer else {
            return false
        }

        return normalize(answer) == normalize(question.correctAnswer)
    }

    func toggleHint() {
        showHint.toggle()
    }

    // MARK: - Helper functions

    func checkQuizAnswer(selectedOption: String, correctOption: String) -> Bool {
        // Normalize both answers before comparing them.
        let selectedAnswer: String = normalize(selectedOption)
        let correctAnswer: String = normalize(correctOption)

        if selectedAnswer == correctAnswer {
            return true
        } else {
            return false
        }
    }

    private func calculateQuizPoints(wasAttemptedIncorrectly: Bool) -> Int {
        // First-try answers earn ten points; later answers earn five points.
        if wasAttemptedIncorrectly {
            return 5
        } else {
            return 10
        }
    }

    private func normalize(_ answer: String) -> String {
        answer.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
