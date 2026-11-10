import SwiftUI

struct ReadingHelperView: View {

    // MARK: - Stored properties

    @Environment(\.dismiss) private var dismiss
    @State private var readingText: String = ""

    // MARK: - Computed properties

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button("Home") {
                dismiss()
            }
            .buttonStyle(.bordered)

            Text("Reading Helper")
                .font(.largeTitle)
                .bold()

            Text("Write a short summary or question about what you are reading.")
                .foregroundStyle(.secondary)

            TextEditor(text: $readingText)
                .font(.body)
                .border(Color.secondary)

            Spacer()
        }
        .padding(24)
        .frame(minWidth: 500, minHeight: 400)
    }
}
