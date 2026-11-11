import SwiftUI

struct LearningAssistantView: View {

    // MARK: - Stored properties

    @State private var viewModel = LearningAssistantViewModel()
    @State private var selectedSubject: LearningSubject = .math
    @State private var userAnswer: String = ""
    @State private var showDoubleCheckAlert: Bool = false
    @State private var showMathResult: Bool = false
    @State private var isMathAnswerCorrect: Bool = false
    @State private var showMathHint: Bool = false
    @State private var expandedQuestionID: UUID?

    // MARK: - Computed properties

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                topBar

                switch selectedSubject {
                case .math:
                    mathSection
                case .science:
                    subjectSection(
                        title: "Science Lab",
                        subtitle: "Explore Grade 4–5 science concepts and test your knowledge.",
                        subject: .science
                    )
                case .socialStudies:
                    subjectSection(
                        title: "Social Studies Hub",
                        subtitle: "Explore government and geography concepts for Grades 4–5.",
                        subject: .socialStudies
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Learning Assistant")
        .alert(
            "Double-Check Your Answer",
            isPresented: $showDoubleCheckAlert
        ) {
            Button("Re-check", role: .cancel) {
            }

            Button("Ready to Submit!") {
                evaluateMathAnswer()
            }
        } message: {
            Text("Did you double-check your calculation before submitting?")
        }
    }

    private var topBar: some View {
        HStack(spacing: 16) {
            subjectPicker
            Spacer()

            Label("\(viewModel.score) Points", systemImage: "star.fill")
                .font(.headline)
                .foregroundStyle(.orange)
        }
    }

    private var subjectPicker: some View {
        Picker("Subject", selection: $selectedSubject) {
            ForEach(LearningSubject.allCases) { subject in
                Label(subject.rawValue, systemImage: subject.icon)
                    .tag(subject)
            }
        }
        .pickerStyle(.segmented)
        .frame(maxWidth: 520)
    }

    private var mathSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            sectionHeader(
                title: "Arithmetic Practice",
                subtitle: "Solve a Grade 4–5 problem, double-check your work, and submit."
            )

            if let mathQuestion = viewModel.currentQuestion(for: .math) {
                VStack(alignment: .leading, spacing: 16) {
                    Text(mathQuestion.questionText)
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity)

                    TextField("Type your answer", text: $userAnswer)
                        .textFieldStyle(.roundedBorder)
                        .font(.title2)
                        .multilineTextAlignment(.center)

                    if showMathResult {
                        mathResultCard(for: mathQuestion)
                    }

                    mathActionButton
                }
                .padding(24)
                .background(.blue.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }

    private var mathActionButton: some View {
        Button(
            showMathResult ? "Next Question" : "Submit Answer",
            systemImage: showMathResult ? "arrow.right" : "checkmark"
        ) {
            if showMathResult {
                advanceToNextQuestion(for: .math)
            } else {
                showDoubleCheckAlert = true
            }
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .frame(maxWidth: .infinity)
        .animation(.easeInOut(duration: 0.2), value: showMathResult)
    }

    private func subjectSection(
        title: String,
        subtitle: String,
        subject: LearningSubject
    ) -> some View {
        let questions: [LearningQuestion] = viewModel.questions(for: subject)
        let currentQuestion: LearningQuestion? = viewModel.currentQuestion(for: subject)
        var conceptQuestions: [LearningQuestion] = []

        for question in questions {
            if question.id != currentQuestion?.id {
                conceptQuestions.append(question)
            }
        }

        return VStack(alignment: .leading, spacing: 20) {
            sectionHeader(title: title, subtitle: subtitle)
            conceptCards(conceptQuestions)

            if let quizQuestion = currentQuestion {
                quizCard(for: quizQuestion)
            }
        }
    }

    private func mathResultCard(for question: LearningQuestion) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            if isMathAnswerCorrect {
                Text("Correct! Great work.")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.green)

                Text("+10 Points")
                    .font(.headline)
            } else {
                Text("Not quite. Try again!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.orange)

                Button("💡 Need a Hint?") {
                    withAnimation {
                        showMathHint.toggle()
                    }
                }
                .buttonStyle(.bordered)

                if showMathHint {
                    Text("Hint: \(question.hint)")
                        .foregroundStyle(.secondary)
                        .transition(.opacity)
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background((isMathAnswerCorrect ? Color.green : Color.orange).opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func conceptCards(_ questions: [LearningQuestion]) -> some View {
        VStack(spacing: 12) {
            ForEach(questions) { question in
                DisclosureGroup(
                    isExpanded: Binding(
                        get: { expandedQuestionID == question.id },
                        set: { isExpanded in
                            expandedQuestionID = isExpanded ? question.id : nil
                        }
                    )
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(question.hint)
                            .foregroundStyle(.secondary)

                        Text("Quick check")
                            .font(.headline)

                        ForEach(question.options, id: \.self) { option in
                            Text("• \(option)")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.top, 8)
                } label: {
                    Label {
                        Text(question.questionText)
                            .font(.headline)
                    } icon: {
                        Image(systemName: question.subject.icon)
                            .foregroundStyle(.blue)
                    }
                }
                .padding(16)
                .background(.blue.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
    }

    private func quizCard(for question: LearningQuestion) -> some View {
        let selectedAnswer: String? = viewModel.selectedAnswer(for: question)

        return VStack(alignment: .leading, spacing: 16) {
            Text("Quick Quiz")
                .font(.title2)
                .bold()

            Text(question.questionText)
                .font(.headline)

            ForEach(question.options, id: \.self) { option in
                Button {
                    viewModel.submit(answer: option, for: question)
                } label: {
                    HStack {
                        Text(option)
                        Spacer()

                        if selectedAnswer == option {
                            Image(
                                systemName: viewModel.isCorrect(
                                    answer: option,
                                    for: question
                                )
                                ? "checkmark.circle.fill"
                                : "xmark.circle.fill"
                            )
                            .foregroundStyle(
                                viewModel.isCorrect(
                                    answer: option,
                                    for: question
                                )
                                ? .green
                                : .red
                            )
                        }
                    }
                }
                .buttonStyle(.bordered)
            }

            if let selectedAnswer {
                Text(
                    viewModel.isCorrect(answer: selectedAnswer, for: question)
                        ? "Correct! Nice work."
                        : "Keep exploring and try again."
                )
                .foregroundStyle(
                    viewModel.isCorrect(answer: selectedAnswer, for: question)
                        ? .green
                        : .orange
                )

                nextQuestionButton(for: question.subject)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.purple.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func sectionHeader(title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.largeTitle)
                .bold()

            Text(subtitle)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }

    private func evaluateMathAnswer() {
        guard let mathQuestion = viewModel.currentQuestion(for: .math) else {
            return
        }

        let trimmedAnswer: String = userAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
        isMathAnswerCorrect = viewModel.submit(answer: trimmedAnswer, for: mathQuestion)
        showMathResult = true
        showMathHint = false
    }

    private func advanceToNextQuestion(for subject: LearningSubject) {
        viewModel.nextQuestion(for: subject)
        userAnswer = ""
        showMathResult = false
        isMathAnswerCorrect = false
        showMathHint = false
        expandedQuestionID = nil
    }

    private func nextQuestionButton(for subject: LearningSubject) -> some View {
        Button("Next Question", systemImage: "arrow.right") {
            advanceToNextQuestion(for: subject)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        LearningAssistantView()
    }
}
