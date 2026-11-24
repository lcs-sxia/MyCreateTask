//
//  LearningAssistantView.swift
//  MyCreateTask
//
//  Created by Steven Xia on 2026-11-10.
//  This code was generated using GitHub Copilot.
//

import SwiftUI

private enum DraftTool: String, CaseIterable, Identifiable {
    case pen = "Pen"
    case eraser = "Eraser"

    var id: String {
        rawValue
    }
}

private struct DraftStroke: Identifiable {
    let id = UUID()
    var points: [CGPoint]
    let color: Color
    let lineWidth: CGFloat
}

struct LearningAssistantView: View {

    // MARK: - Stored properties

    @State private var viewModel = LearningAssistantViewModel()
    // This value remembers which subject is currently open.
    @State private var selectedSubject: LearningSubject = .math
    @State private var expandedQuestionID: UUID?
    @State private var showingPointsPopover: Bool = false
    @State private var showingDraftSheet: Bool = false
    // The draft arrays store drawn stroke colors and positions.
    @State private var draftStrokes: [DraftStroke] = []
    @State private var draftPenColor: Color = .black
    @State private var draftTool: DraftTool = .pen
    @State private var draftActiveStrokeID: UUID?

    // MARK: - Computed properties

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            learningAssistantHeader
            topBar
            selectedSubjectSection
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, 28)
        .padding(.top, 16)
        .padding(.bottom, 16)
        .navigationTitle("Learning Assistant")
        .onChange(of: selectedSubject) {
            viewModel.resetForSubjectChange()
        }
    }

    // This header introduces the Learning Assistant screen.
    private var learningAssistantHeader: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Learning Assistant")
                .font(.largeTitle.bold())

            Text("Practice, explain, and strengthen your understanding.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    // This section selects the header and data for the active subject.
    @ViewBuilder
    private var selectedSubjectSection: some View {
        switch selectedSubject {
        case .math:
            subjectSection(
                title: "Math Workshop",
                subtitle: "Solve math problems and explain your thinking.",
                subject: .math
            )
        case .science:
            subjectSection(
                title: "Science Lab",
                subtitle: "Explore science concepts and test your knowledge.",
                subject: .science
            )
        case .socialStudies:
            subjectSection(
                title: "Social Studies Hub",
                subtitle: "Explore government and geography concepts",
                subject: .socialStudies
            )
        case .english:
            subjectSection(
                title: "English (Grammar)",
                subtitle: "Practice sentence structure, word choice, and grammar.",
                subject: .english
            )
        case .geography:
            subjectSection(
                title: "Geography",
                subtitle: "Explore maps, regions, resources, and human–natural systems.",
                subject: .geography
            )
        }
    }

    private var topBar: some View {
        HStack(spacing: 16) {
            subjectPicker
            Spacer()

            Button {
                showingDraftSheet = true
            } label: {
                Label("Draft", systemImage: "pencil.and.outline")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(Color.primary.opacity(0.06), in: Capsule())
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showingDraftSheet) {
                draftSheet
            }

            Button {
                showingPointsPopover = true
            } label: {
                Label("\(viewModel.score) Points", systemImage: "star.fill")
                    .font(.headline)
                    .foregroundStyle(.orange)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .background(.orange.opacity(0.14), in: Capsule())
            }
            .buttonStyle(.plain)
            .popover(isPresented: $showingPointsPopover) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("How Points Work")
                        .font(.headline)

                    Text("You earn +10 points for every question you answer correctly on your first try, and +5 points on a second try!")
                        .font(.body)
                        .foregroundStyle(.primary)
                        .frame(width: 260, alignment: .leading)
                }
                .padding(16)
            }
        }
    }

    private var draftSheet: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Rough Work & Draft Notes")
                        .font(.title2.weight(.bold))

                    Text("Draw calculations, shapes, and ideas.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button("Done") {
                    showingDraftSheet = false
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }

            if let activeQuestion = viewModel.currentQuestion(for: selectedSubject) {
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "questionmark.circle.fill")
                        .foregroundStyle(subjectThemeColor(for: selectedSubject))

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Active Question")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(subjectThemeColor(for: selectedSubject))

                        Text(activeQuestion.questionText)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(12)
                .background(subjectThemeColor(for: selectedSubject).opacity(0.10), in: RoundedRectangle(cornerRadius: 12))
            }

            HStack(spacing: 8) {
                penColorPill(title: "Black", color: .black)
                penColorPill(title: "Blue", color: .blue)
                penColorPill(title: "Red", color: .red)

                Divider()
                    .frame(height: 28)

                Button {
                    draftTool = .eraser
                } label: {
                    Label("Eraser", systemImage: "eraser")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(draftTool == .eraser ? .white : .primary)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 6)
                        .background(
                            draftTool == .eraser ? Color.orange : Color.primary.opacity(0.06),
                            in: Capsule()
                        )
                }
                .buttonStyle(.plain)

                Spacer()

                Button("Undo", systemImage: "arrow.uturn.backward") {
                    if !draftStrokes.isEmpty {
                        draftStrokes.removeLast()
                    }
                }
                .buttonStyle(.bordered)
                .disabled(draftStrokes.isEmpty)

                Button("Clear", systemImage: "trash") {
                    draftStrokes = []
                    draftActiveStrokeID = nil
                }
                .buttonStyle(.bordered)
                .disabled(draftStrokes.isEmpty)
            }

            Canvas { context, _ in
                for stroke in draftStrokes {
                    guard stroke.points.count > 1 else {
                        continue
                    }

                    var path = Path()
                    path.move(to: stroke.points[0])
                    for point in stroke.points.dropFirst() {
                        path.addLine(to: point)
                    }

                    context.stroke(
                        path,
                        with: .color(stroke.color),
                        style: StrokeStyle(
                            lineWidth: stroke.lineWidth,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white, in: RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.secondary.opacity(0.18), lineWidth: 1)
            )
            .contentShape(RoundedRectangle(cornerRadius: 14))
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if draftTool == .eraser {
                            eraseDraftStroke(at: value.location)
                        } else {
                            if let activeID = draftActiveStrokeID,
                               let strokeIndex = draftStrokes.firstIndex(where: { $0.id == activeID }) {
                                draftStrokes[strokeIndex].points.append(value.location)
                            } else {
                                let stroke = DraftStroke(
                                    points: [value.location],
                                    color: draftPenColor,
                                    lineWidth: 4
                                )
                                draftStrokes.append(stroke)
                                draftActiveStrokeID = stroke.id
                            }
                        }
                    }
                    .onEnded { _ in
                        draftActiveStrokeID = nil
                    }
            )
        }
        .padding(20)
        .frame(minWidth: 650, minHeight: 480)
    }

    private func penColorPill(title: String, color: Color) -> some View {
        let isSelected = draftPenColor == color && draftTool == .pen

        return Button {
            draftPenColor = color
            draftTool = .pen
        } label: {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(isSelected ? color : Color.primary.opacity(0.06), in: Capsule())
        }
        .buttonStyle(.plain)
    }

    private func eraseDraftStroke(at location: CGPoint) {
        var remainingStrokes: [DraftStroke] = []

        // Check each stroke and keep only strokes that the eraser did not touch.
        for stroke in draftStrokes {
            var strokeWasErased: Bool = false

            for point in stroke.points {
                let horizontalDistance = point.x - location.x
                let verticalDistance = point.y - location.y
                let distance = sqrt(
                    (horizontalDistance * horizontalDistance) +
                    (verticalDistance * verticalDistance)
                )
                if distance <= 16 {
                    strokeWasErased = true
                    break
                }
            }

            if !strokeWasErased {
                remainingStrokes.append(stroke)
            }
        }

        draftStrokes = remainingStrokes
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
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(
                        selectedSubject == subject
                            ? .white
                            : .primary
                    )
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background {
                        if selectedSubject == subject {
                            Capsule()
                                .fill(subjectThemeColor(for: subject))
                        } else {
                            Capsule()
                                .fill(Color.primary.opacity(0.06))
                        }
                    }
                    .contentShape(Capsule())
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func subjectThemeColor(for subject: LearningSubject) -> Color {
        switch subject {
        case .math:
            return .blue
        case .science:
            return .green
        case .socialStudies:
            return .purple
        case .english:
            return .pink
        case .geography:
            return .orange
        }
    }

    private func subjectTabIcon(for subject: LearningSubject) -> String {
        switch subject {
        case .math:
            "function"
        case .science:
            "atom"
        case .socialStudies:
            "globe.americas.fill"
        case .english:
            "pencil.and.outline"
        case .geography:
            "map"
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
                                .foregroundStyle(.primary.opacity(0.88))
                                .fixedSize(horizontal: false, vertical: true)
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

            gardenPerimeterDiagram(for: question)

            Text(question.questionText)
                .font(.title3)
                .foregroundStyle(.primary)

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
                                .font(.body)
                                .foregroundStyle(.primary)
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

                if isAnswerCorrect {
                    Text("Correct! Nice work.")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.green)
                    nextQuestionButton(for: question.subject)
                } else if viewModel.hasFailedCurrentQuestion {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Not quite! Give it another try.")
                            .font(.body.weight(.semibold))
                            .foregroundStyle(.orange)

                        HStack(spacing: 8) {
                            Button("Try Again") {
                                viewModel.tryAgain(for: question)
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)

                            Button("Need a Hint?") {
                                viewModel.toggleHint()
                            }
                            .buttonStyle(.bordered)
                        }

                        if viewModel.showHint {
                            Text("Hint: \(question.hint)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.purple.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    @ViewBuilder
    private func gardenPerimeterDiagram(for question: LearningQuestion) -> some View {
        if question.subject == .math &&
            question.questionText ==
            "A rectangular garden is 12 meters long and 8 meters wide. What is its total perimeter?" {
            VStack(spacing: 4) {
                Text("12 m")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 8)
                    .background(.white, in: Capsule())

                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.blue, lineWidth: 2)
                        .frame(width: 180, height: 112)

                    HStack {
                        Spacer()
                        Text("8 m")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.blue)
                            .padding(.horizontal, 6)
                            .background(.white, in: Capsule())
                            .padding(.trailing, -34)
                    }
                    .frame(width: 180, height: 112)
                }
            }
            .padding(12)
            .frame(maxWidth: .infinity)
            .background(.blue.opacity(0.05), in: RoundedRectangle(cornerRadius: 12))
        }
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
