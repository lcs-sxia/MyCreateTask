import SwiftUI

struct LearningAssistantView: View {

    // MARK: - Stored properties

    @State private var viewModel = LearningAssistantViewModel()
    @State private var selectedSubject: LearningSubject = .math
    @State private var expandedQuestionID: UUID?

    // MARK: - Computed properties

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            topBar

            switch selectedSubject {
            case .math:
                subjectSection(
                    title: "Math Workshop",
                    subtitle: "Solve Grade 4–5 word problems and explain your thinking.",
                    subject: .math
                )
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
        .frame(maxWidth: 960, maxHeight: .infinity, alignment: .top)
        .padding(24)
        .navigationTitle("Learning Assistant")
        .onChange(of: selectedSubject) {
            viewModel.resetForSubjectChange()
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
        HStack(spacing: 6) {
            ForEach(LearningSubject.allCases) { subject in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedSubject = subject
                    }
                } label: {
                    Label {
                        Text(subject.rawValue)
                    } icon: {
                        Image(systemName: subjectTabIcon(for: subject))
                    }
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(
                        selectedSubject == subject
                            ? Color.accentColor
                            : Color.secondary
                    )
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background {
                        if selectedSubject == subject {
                            Capsule()
                                .fill(Color.accentColor.opacity(0.14))
                                .shadow(
                                    color: .black.opacity(0.08),
                                    radius: 4,
                                    y: 2
                                )
                        }
                    }
                    .contentShape(Capsule())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(Color.secondary.opacity(0.08), in: Capsule())
    }

    private func subjectTabIcon(for subject: LearningSubject) -> String {
        switch subject {
        case .math:
            "function"
        case .science:
            "atom"
        case .socialStudies:
            "globe.americas.fill"
        }
    }

    private func subjectSection(
        title: String,
        subtitle: String,
        subject: LearningSubject
    ) -> some View {
        let currentQuestion: LearningQuestion? = viewModel.currentQuestion(for: subject)
        let studyConcepts: [StudyConcept] = viewModel.studyConcepts(for: subject)

        return VStack(alignment: .leading, spacing: 20) {
            sectionHeader(title: title, subtitle: subtitle)
            conceptCards(studyConcepts)

            if let quizQuestion = currentQuestion {
                quizCard(for: quizQuestion)
            }
        }
    }

    private func conceptCards(_ concepts: [StudyConcept]) -> some View {
        LazyVGrid(
            columns: Array(
                repeating: GridItem(.flexible(), spacing: 12),
                count: 3
            ),
            spacing: 12
        ) {
            ForEach(concepts) { concept in
                Button {
                    if expandedQuestionID == concept.id {
                        expandedQuestionID = nil
                    } else {
                        expandedQuestionID = concept.id
                    }
                } label: {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .top, spacing: 8) {
                            Label {
                                Text(concept.title)
                                    .font(.subheadline.weight(.bold))
                                    .multilineTextAlignment(.leading)
                            } icon: {
                                Image(systemName: concept.subject.icon)
                                    .foregroundStyle(.blue)
                            }

                            Spacer(minLength: 4)

                            Image(
                                systemName: expandedQuestionID == concept.id
                                    ? "chevron.up"
                                    : "chevron.down"
                            )
                            .foregroundStyle(.secondary)
                        }

                        if expandedQuestionID == concept.id {
                            Text(concept.summary)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .buttonStyle(.plain)
                .padding(12)
                .frame(maxWidth: .infinity, minHeight: 82, alignment: .topLeading)
                .background(.blue.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .contentShape(Rectangle())
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

            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ],
                spacing: 12
            ) {
                ForEach(question.options, id: \.self) { option in
                    let isWrongOption: Bool = viewModel.wrongSelectedOptions.contains(option)
                    let isSelectedOption: Bool = selectedAnswer == option

                    Button {
                        viewModel.submit(answer: option, for: question)
                    } label: {
                        HStack {
                            Text(option)
                                .multilineTextAlignment(.leading)
                            Spacer(minLength: 4)

                            if isWrongOption {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.red)
                            } else if isSelectedOption {
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
                        .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
                    }
                    .buttonStyle(.bordered)
                    .tint(isWrongOption ? .red : .accentColor)
                    .background(
                        isWrongOption
                            ? Color.red.opacity(0.08)
                            : Color.clear
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .disabled(isWrongOption)
                }
            }

            if let selectedAnswer {
                let isAnswerCorrect: Bool = viewModel.isCorrect(
                    answer: selectedAnswer,
                    for: question
                )

                Text(isAnswerCorrect ? "Correct! Nice work." : "Keep exploring and try again.")
                    .foregroundStyle(isAnswerCorrect ? .green : .orange)

                if !isAnswerCorrect {
                    Button("💡 Need a Hint?") {
                        viewModel.toggleHint()
                    }
                    .buttonStyle(.bordered)

                    if viewModel.showHint {
                        Text("Hint: \(question.hint)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                if isAnswerCorrect {
                    nextQuestionButton(for: question.subject)
                }
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

    private func advanceToNextQuestion(for subject: LearningSubject) {
        viewModel.nextQuestion(for: subject)
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
