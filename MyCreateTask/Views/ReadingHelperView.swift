//
//  ReadingHelperView.swift
//  MyCreateTask
//
//  Created by Steven Xia on 2026-11-10.
//  This code was generated using GitHub Copilot.
//

import SwiftUI
import Combine

struct ReadingHelperView: View {

    // MARK: - Stored properties

    @State private var viewModel = ReadingHelperViewModel()

    // MARK: - Computed properties

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                readingHelperHeader
                readingTypeSelector
                selectedReadingSection
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

    // This header identifies the Reading Helper screen.
    private var readingHelperHeader: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Reading Helper")
                .font(.largeTitle.weight(.bold))

            Text("Vocabulary and reading comprehension")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    // These pills switch between vocabulary cards and reading passages.
    private var readingTypeSelector: some View {
        HStack(spacing: 8) {
            readingTypePill(title: "Vocabulary", type: .vocabulary)
            readingTypePill(title: "Reading Passages", type: .passage)
        }
    }

    // This section displays the selected reading mode.
    @ViewBuilder
    private var selectedReadingSection: some View {
        if viewModel.selectedType == .vocabulary {
            vocabularySection
        } else {
            passageSection
        }
    }

    private var vocabularySection: some View {
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

        return capsuleButton(
            title: title,
            isSelected: isSelected,
            selectedColor: .blue
        ) {
            if viewModel.selectedPartOfSpeech != partOfSpeech {
                viewModel.selectedPartOfSpeech = partOfSpeech
            }
        }
    }

    private func readingTypePill(title: String, type: ReadingItemType) -> some View {
        capsuleButton(
            title: title,
            isSelected: viewModel.selectedType == type,
            selectedColor: .blue
        ) {
            if viewModel.selectedType != type {
                viewModel.selectedType = type
            }
        }
    }

    private func capsuleButton(
        title: String,
        isSelected: Bool,
        selectedColor: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(
                    isSelected ? selectedColor : Color.primary.opacity(0.06),
                    in: Capsule()
                )
        }
        .buttonStyle(.plain)
        .clipShape(Capsule())
    }

    private func vocabularyCard(_ item: ReadingItem) -> some View {
        let isRevealed = viewModel.isVocabularyRevealed(item)
        let isMastered = viewModel.isVocabularyMastered(item)
        let definition = item.definition ?? ""
        let exampleSentence = item.exampleSentence ?? ""
        let synonym = item.synonym ?? ""

        return ZStack {
            ZStack(alignment: .topLeading) {
                HStack {
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
                .frame(maxWidth: .infinity)

                VStack(alignment: .center, spacing: 8) {
                    Text(item.title)
                        .font(.title2.weight(.bold))
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.center)

                    vocabularyPartOfSpeechPill(item.partOfSpeech)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                VStack {
                    Spacer()
                    Text("Tap to reveal meaning")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(14)
            .background(.quaternary.opacity(0.7), in: RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        isMastered
                            ? Color.green.opacity(0.5)
                            : Color.secondary.opacity(0.12),
                        lineWidth: isMastered ? 1.5 : 1
                    )
            )
            .rotation3DEffect(
                .degrees(isRevealed ? 180 : 0),
                axis: (x: 0, y: 1, z: 0)
            )
            .opacity(isRevealed ? 0 : 1)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(item.title)
                        .font(.headline.weight(.bold))
                        .foregroundStyle(.primary)

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

                Text(definition)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)

                Text("Example:")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)

                Text(exampleSentence)
                    .font(.caption)
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)

                Text("Synonym: \(synonym)")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(.blue.opacity(0.14), in: Capsule())

                Spacer()

                Text("Tap to flip back")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(14)
            .background(.blue.opacity(0.10), in: RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.blue.opacity(0.25), lineWidth: 1)
            )
            .rotation3DEffect(
                .degrees(isRevealed ? 0 : -180),
                axis: (x: 0, y: 1, z: 0)
            )
            .opacity(isRevealed ? 1 : 0)
        }
        .frame(height: 210)
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.35)) {
                viewModel.toggleVocabularyReveal(item)
            }
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
        return VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Text("Category:")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)

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

                HStack(spacing: 8) {
                    Text("Level:")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)

                    ForEach(ReadingLevelFilter.allCases) { level in
                        passageLevelPill(level)
                    }
                }

                HStack(spacing: 8) {
                    Text("Time:")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)

                    ForEach(ReadingTimeFilter.allCases) { time in
                        passageTimePill(time)
                    }
                }
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

        return capsuleButton(
            title: title,
            isSelected: isSelected,
            selectedColor: .orange
        ) {
            if viewModel.selectedPassageCategory != category {
                viewModel.selectedPassageCategory = category
            }
        }
    }

    private func passageLevelPill(_ level: ReadingLevelFilter) -> some View {
        let isSelected = viewModel.selectedPassageLevel == level

        return capsuleButton(
            title: level.rawValue,
            isSelected: isSelected,
            selectedColor: .purple
        ) {
            viewModel.selectedPassageLevel = level
        }
    }

    private func passageTimePill(_ time: ReadingTimeFilter) -> some View {
        let isSelected = viewModel.selectedPassageTime == time

        return capsuleButton(
            title: time.rawValue,
            isSelected: isSelected,
            selectedColor: .orange
        ) {
            viewModel.selectedPassageTime = time
        }
    }

    private func readingLevelLabel(for passage: ReadingItem) -> String {
        switch passage.readingLevel {
        case 1:
            return "Level 1 • Easy"
        case 2:
            return "Level 2 • Medium"
        case 3:
            return "Level 3 • Advanced"
        default:
            return "Level 1 • Easy"
        }
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

            HStack(spacing: 6) {
                Text(passage.category ?? "")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(.blue.opacity(0.14), in: Capsule())

                Text(readingLevelLabel(for: passage))
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.purple)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(.purple.opacity(0.14), in: Capsule())
            }

            Text(passage.summary ?? "")
                .font(.subheadline)
                .foregroundStyle(.primary.opacity(0.85))
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 10) {
                Label("\(passage.readingTime ?? 0) min read", systemImage: "clock.fill")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.orange)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(.orange.opacity(0.14), in: Capsule())

                Label("\(passage.wordCount ?? 0) words", systemImage: "text.alignleft")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
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

    private func readingLevelLabel(for passage: ReadingItem) -> String {
        switch passage.readingLevel {
        case 1:
            return "Level 1 • Easy"
        case 2:
            return "Level 2 • Medium"
        case 3:
            return "Level 3 • Advanced"
        default:
            return "Level 1 • Easy"
        }
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

                    HStack(spacing: 6) {
                        Text(readingLevelLabel(for: passage))
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.purple)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                            .background(.purple.opacity(0.14), in: Capsule())

                        Label("\(passage.readingTime ?? 0) min read", systemImage: "clock.fill")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.orange)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                            .background(.orange.opacity(0.14), in: Capsule())
                    }

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
                    .lineSpacing(6)
                    .foregroundStyle(.primary)
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
                            .font(.subheadline)
                            .foregroundStyle(.primary.opacity(0.88))
                            .fixedSize(horizontal: false, vertical: true)
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
                        .font(.body.weight(.bold))
                        .foregroundStyle(.primary)
                        .fixedSize(horizontal: false, vertical: true)

                    ForEach(Array(question.options.enumerated()), id: \.offset) { option in
                        Button {
                            selectedAnswers[question.id] = option.offset
                        } label: {
                            HStack {
                                Text(option.element)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .font(.subheadline)
                            .frame(maxWidth: .infinity)
                            .fixedSize(horizontal: false, vertical: true)
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
                                .font(.subheadline)
                                .foregroundStyle(.primary.opacity(0.88))
                                .fixedSize(horizontal: false, vertical: true)
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
