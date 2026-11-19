import SwiftUI
import Combine

struct ReadingHelperView: View {

    // MARK: - Stored properties

    @State private var viewModel = ReadingHelperViewModel()

    // MARK: - Computed properties

    var body: some View {
        @Bindable var viewModel = viewModel

        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Reading Helper")
                        .font(.largeTitle.weight(.bold))

                    Text("Grade 5–6 vocabulary and comprehension")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                HStack(alignment: .top, spacing: 0) {
                    Picker("Reading type", selection: $viewModel.selectedType) {
                        ForEach(ReadingItemType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.segmented)
                }

                if viewModel.selectedType == .vocabulary {
                    vocabularySection
                } else {
                    passageSection
                }
            }
            .padding(.horizontal, 28)
            .padding(.top, 16)
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .fontDesign(.rounded)
        .navigationTitle("Reading Helper")
    }

    // MARK: - Views

    private var vocabularySection: some View {
        @Bindable var viewModel = viewModel

        return VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Text("Part of Speech:")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)

                partOfSpeechPill(title: "All", partOfSpeech: nil)
                ForEach(ReadingPartOfSpeech.allCases) { partOfSpeech in
                    partOfSpeechPill(
                        title: partOfSpeech.rawValue,
                        partOfSpeech: partOfSpeech
                    )
                }

                Spacer()

                Text("\(viewModel.masteredVocabularyCount) of \(viewModel.totalVocabularyCount) Mastered")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(.blue.opacity(0.12), in: Capsule())

                Button("Random Word", systemImage: "shuffle") {
                    if let randomWord = viewModel.vocabularyItems.randomElement() {
                        viewModel.revealVocabulary(randomWord)
                    }
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
                .disabled(viewModel.vocabularyItems.isEmpty)
            }

            if viewModel.vocabularyItems.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "text.book.closed")
                        .font(.title)
                        .foregroundStyle(.secondary)
                    Text("No vocabulary words match this filter.")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, minHeight: 180)
            } else {
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 12),
                        GridItem(.flexible(), spacing: 12),
                        GridItem(.flexible(), spacing: 12)
                    ],
                    spacing: 12
                ) {
                    ForEach(viewModel.vocabularyItems) { item in
                        vocabularyCard(item)
                    }
                }
            }
        }
    }

    private func partOfSpeechPill(
        title: String,
        partOfSpeech: ReadingPartOfSpeech?
    ) -> some View {
        let isSelected = viewModel.selectedPartOfSpeech == partOfSpeech

        return Button(title) {
            viewModel.selectedPartOfSpeech = partOfSpeech
        }
        .buttonStyle(.bordered)
        .controlSize(.small)
        .tint(isSelected ? .blue : nil)
    }

    private func vocabularyCard(_ item: ReadingItem) -> some View {
        let isRevealed = viewModel.isVocabularyRevealed(item)
        let isMastered = viewModel.isVocabularyMastered(item)
        let definition = item.definition ?? ""
        let exampleSentence = item.exampleSentence ?? ""
        let synonym = item.synonym ?? ""

        return VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Text(item.title)
                    .font(.headline.weight(.bold))
                    .lineLimit(1)

                Spacer()

                Button {
                    viewModel.toggleVocabularyMastered(item)
                } label: {
                    Image(systemName: isMastered ? "checkmark.circle.fill" : "circle")
                        .font(.title3)
                }
                .buttonStyle(.plain)
                .foregroundStyle(isMastered ? .green : .secondary)
                .help(isMastered ? "Mark not mastered" : "Mark mastered")
            }

            vocabularyPartOfSpeechPill(item.partOfSpeech)

            Text(definition)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(3)

            Text(isRevealed ? "Show less" : "Tap for example & synonym")
                .font(.caption2.weight(.semibold))
                .foregroundStyle(isRevealed ? .blue : .secondary)

            if isRevealed {
                VStack(alignment: .leading, spacing: 6) {
                    Text(exampleSentence)
                        .font(.caption)

                    Text("Synonym: \(synonym)")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.blue)
                }
                vocabularyMasteryButton(item: item, isMastered: isMastered)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(16)
        .background(.quaternary.opacity(0.7), in: RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    isMastered
                        ? Color.green.opacity(0.5)
                        : isRevealed
                            ? Color.blue.opacity(0.45)
                            : Color.secondary.opacity(0.12),
                    lineWidth: isRevealed ? 1.5 : 1
                )
        }
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.toggleVocabularyReveal(item)
        }
    }

    private func vocabularyPartOfSpeechPill(_ partOfSpeech: ReadingPartOfSpeech?) -> some View {
        let title = partOfSpeech?.rawValue ?? ""
        let tint: Color

        switch partOfSpeech {
        case .adjective:
            tint = .blue
        case .verb:
            tint = .orange
        case .noun:
            tint = .purple
        case nil:
            tint = .secondary
        }

        return Text(title)
            .font(.caption2.weight(.bold))
            .foregroundStyle(tint)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(tint.opacity(0.14), in: Capsule())
    }

    private func vocabularyDetails(
        definition: String,
        exampleSentence: String,
        synonym: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(definition)
                .font(.subheadline)

            Text(exampleSentence)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text("Synonym: \(synonym)")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.blue)
        }
    }

    private func vocabularyMasteryButton(
        item: ReadingItem,
        isMastered: Bool
    ) -> some View {
        if isMastered {
            return AnyView(
                Button("Mastered", systemImage: "checkmark.circle.fill") {
                    viewModel.toggleVocabularyMastered(item)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.small)
            )
        } else {
            return AnyView(
                Button("Mark Mastered", systemImage: "circle") {
                    viewModel.toggleVocabularyMastered(item)
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
            )
        }
    }

    private var passageSection: some View {
        @Bindable var viewModel = viewModel

        return VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        passageCategoryPill(title: "All", category: nil)
                        passageCategoryPill(title: "Canadian Nature", category: "Canadian Nature")
                        passageCategoryPill(title: "Science & Inquiry", category: "Science & Inquiry")
                        passageCategoryPill(title: "Community & History", category: "Community & History")
                    }
                }

                Spacer()

                Text("\(viewModel.passageItems.count) Passages")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(.blue.opacity(0.12), in: Capsule())
            }

            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 14),
                    GridItem(.flexible(), spacing: 14)
                ],
                spacing: 14
            ) {
                ForEach(viewModel.passageItems) { passage in
                    NavigationLink {
                        ReadingPassageDetailView(passage: passage)
                    } label: {
                        passageCard(passage)
                    }
                    .buttonStyle(.plain)
                    .contentShape(Rectangle())
                }
            }
        }
    }

    private func passageCategoryPill(
        title: String,
        category: String?
    ) -> some View {
        let isSelected = viewModel.selectedPassageCategory == category

        return Button(title) {
            viewModel.selectedPassageCategory = category
        }
        .buttonStyle(.bordered)
        .controlSize(.small)
        .tint(isSelected ? .blue : nil)
    }

    private func passageCard(_ passage: ReadingItem) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 8) {
                Text(passage.title)
                    .font(.headline.weight(.bold))

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)
            }

            Text(passage.category ?? "")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.blue)
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(.blue.opacity(0.14), in: Capsule())

            Text(passage.summary ?? "")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)

            HStack(spacing: 10) {
                Label("\(passage.readingTime ?? 0) min read", systemImage: "clock")
                Label("\(passage.wordCount ?? 0) words", systemImage: "text.alignleft")
            }
            .font(.caption.weight(.semibold))
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 128, alignment: .topLeading)
        .padding(12)
        .background(.orange.opacity(0.10), in: RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.secondary.opacity(0.12), lineWidth: 1)
        }
    }
}

struct ReadingPassageDetailView: View {

    // MARK: - Stored properties

    let passage: ReadingItem
    @State private var secondsRemaining: Int
    @State private var isTimerRunning: Bool = false
    @State private var selectedAnswers: [UUID: Int] = [:]

    // MARK: - Initializer

    init(passage: ReadingItem) {
        self.passage = passage
        _secondsRemaining = State(initialValue: (passage.readingTime ?? 4) * 60)
    }

    // MARK: - Computed properties

    var timerText: String {
        let minutes = secondsRemaining / 60
        let seconds = secondsRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    // MARK: - Computed properties

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(passage.title)
                        .font(.largeTitle.weight(.bold))

                    Text(passage.category ?? "")
                        .font(.headline)
                        .foregroundStyle(.blue)

                    Text(passage.summary ?? "")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }

                HStack(alignment: .top, spacing: 16) {
                    passageColumn
                        .frame(maxWidth: .infinity, alignment: .topLeading)

                    VStack(alignment: .leading, spacing: 12) {
                        readingCheck
                            .frame(maxWidth: .infinity, alignment: .topLeading)

                        timerCard
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                }
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .fontDesign(.rounded)
        .navigationTitle(passage.title)
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if isTimerRunning && secondsRemaining > 0 {
                secondsRemaining -= 1
            } else if secondsRemaining == 0 {
                isTimerRunning = false
            }
        }
    }

    // MARK: - Views

    private var passageColumn: some View {
        VStack(alignment: .leading, spacing: 14) {
            ForEach(Array(passage.passageParagraphs.enumerated()), id: \.offset) { paragraph in
                Text(paragraph.element)
                    .font(.body)
                    .lineSpacing(5)
            }

            VStack(alignment: .leading, spacing: 8) {
                Label("Key Vocabulary", systemImage: "text.book.closed")
                    .font(.headline)
                    .foregroundStyle(.blue)

                ForEach(passage.keyVocabulary) { term in
                    VStack(alignment: .leading, spacing: 2) {
                        Text(term.term)
                            .font(.subheadline.weight(.bold))
                        Text(term.meaning)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(14)
            .background(.blue.opacity(0.08), in: RoundedRectangle(cornerRadius: 14))
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(18)
        .background(.quaternary.opacity(0.55), in: RoundedRectangle(cornerRadius: 16))
    }

    private var readingCheck: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Reading Check", systemImage: "checklist")
                .font(.headline)
                .foregroundStyle(.blue)

            ForEach(passage.questions) { question in
                VStack(alignment: .leading, spacing: 7) {
                    Text(question.prompt)
                        .font(.subheadline.weight(.bold))

                    ForEach(Array(question.options.enumerated()), id: \.offset) { option in
                        Button {
                            selectedAnswers[question.id] = option.offset
                        } label: {
                            HStack {
                                Text(option.element)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.small)
                        .tint(optionTint(question: question, optionIndex: option.offset))
                    }

                    if let selectedIndex = selectedAnswers[question.id] {
                        HStack(alignment: .top, spacing: 6) {
                            Image(systemName: selectedIndex == question.correctOptionIndex ? "checkmark.circle.fill" : "exclamationmark.circle.fill")
                                .foregroundStyle(selectedIndex == question.correctOptionIndex ? .green : .orange)
                            Text(question.explanation)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.top, 2)
                    }
                }
                .padding(.bottom, 4)
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(14)
        .background(.green.opacity(0.07), in: RoundedRectangle(cornerRadius: 14))
    }

    private var timerCard: some View {
        VStack(spacing: 8) {
            Label("Reading Timer", systemImage: "timer")
                .font(.headline)

            Text(timerText)
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .monospacedDigit()

            if secondsRemaining == 0 {
                Text("Reading time complete!")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.green)
            }

            HStack(spacing: 8) {
                Button(isTimerRunning ? "Pause" : "Start", systemImage: isTimerRunning ? "pause.fill" : "play.fill") {
                    if secondsRemaining > 0 {
                        isTimerRunning.toggle()
                    }
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.small)

                Button("Reset", systemImage: "arrow.counterclockwise") {
                    secondsRemaining = (passage.readingTime ?? 4) * 60
                    isTimerRunning = false
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
            }
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .padding(14)
        .background(.orange.opacity(0.08), in: RoundedRectangle(cornerRadius: 14))
    }

    private func optionTint(question: ReadingQuestion, optionIndex: Int) -> Color? {
        guard let selectedIndex = selectedAnswers[question.id] else {
            return nil
        }

        if optionIndex == question.correctOptionIndex {
            return .green
        }

        if optionIndex == selectedIndex {
            return .orange
        }

        return nil
    }
}
