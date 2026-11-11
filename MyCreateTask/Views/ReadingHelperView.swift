import SwiftUI

struct ReadingHelperView: View {

    // MARK: - Stored properties

    @State private var viewModel = ReadingHelperViewModel()

    // MARK: - Computed properties

    var body: some View {
        @Bindable var viewModel = viewModel

        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Reading Helper")
                    .font(.largeTitle)
                    .bold()

                if let readingItem = viewModel.readingItems.first {
                    Text(readingItem.summary)
                        .foregroundStyle(.secondary)
                }

                TextEditor(text: $viewModel.readingText)
                    .font(.body)
                    .border(Color.secondary)

                Spacer()
            }
        }
        .padding()
    }
}
