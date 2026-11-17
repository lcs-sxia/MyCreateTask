import SwiftUI

struct ReadingHelperView: View {

    // MARK: - Stored properties

    @State private var viewModel = ReadingHelperViewModel()

    // MARK: - Computed properties

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Reading Helper")
                    .font(.largeTitle.weight(.bold))

                Picker("Reading type", selection: $viewModel.selectedType) {
                    ForEach(ReadingItemType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)

                if viewModel.selectedType == .vocabulary {
                    vocabularySection
                } else {
                    passageSection
                }

                Spacer()
            }
            .fontDesign(.rounded)
        }
        .padding()
        .navigationTitle("Reading Helper")
    }

    // MARK: - Views

    private var vocabularySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Tap a word to reveal its meaning and an example.")
                .foregroundStyle(.secondary)

            ForEach(viewModel.vocabularyItems) { item in
                Button {
                    viewModel.toggleVocabularyReveal(item)
                } label: {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(item.title)
                                .font(.title2.weight(.bold))
                            Spacer()
                            Image(systemName: viewModel.isVocabularyRevealed(item) ? "chevron.up" : "chevron.down")
                        }

                        if let partOfSpeech = item.partOfSpeech {
                            Text(partOfSpeech)
                                .italic()
                                .foregroundStyle(.secondary)
                        }

                        if viewModel.isVocabularyRevealed(item) {
                            if let definition = item.definition {
                                Text("Definition: \(definition)")
                            }

                            if let exampleSentence = item.exampleSentence {
                                Text("Example: \(exampleSentence)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .buttonStyle(.plain)
                .foregroundStyle(.primary)
            }
        }
    }

    private var passageSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("\(viewModel.readPassageCount)/\(viewModel.passageItems.count) Passages Read")
                .font(.headline)
                .foregroundStyle(.secondary)

            ForEach(viewModel.passageItems) { item in
                passageCard(for: item)
            }
        }
    }

    private func passageCard(for item: ReadingItem) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(item.title)
                .font(.title2.weight(.bold))

            if let passage = item.passage {
                Text(passage)
            }

            if let question = item.question {
                Text(question)
                    .font(.headline)

                TextField("Type your answer", text: Binding(
                    get: {
                        viewModel.selectedAnswer(for: item)
                    },
                    set: { answer in
                        viewModel.submitAnswer(answer, for: item)
                    }
                ))
                .textFieldStyle(.roundedBorder)
            }

            HStack {
                Button(viewModel.isPassageRead(item) ? "Read" : "Mark as Read", systemImage: "checkmark") {
                    viewModel.markPassageAsRead(item)
                }
                .buttonStyle(.borderedProminent)

                if !viewModel.selectedAnswer(for: item).isEmpty {
                    Text(viewModel.isAnswerCorrect(for: item) ? "Correct!" : "Keep thinking!")
                        .foregroundStyle(viewModel.isAnswerCorrect(for: item) ? .green : .orange)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.orange.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
