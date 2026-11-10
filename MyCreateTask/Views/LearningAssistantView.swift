import SwiftUI

struct LearningAssistantView: View {

    // MARK: - Stored properties

    @Environment(\.dismiss) private var dismiss
    @State private var showingDoubleCheck: Bool = true

    // MARK: - Computed properties

    var body: some View {
        VStack(spacing: 20) {
            Button("Home") {
                dismiss()
            }
            .buttonStyle(.bordered)

            Image(systemName: "checkmark.shield")
                .font(.system(size: 60))
                .foregroundStyle(.tint)

            Text("Learning Assistant")
                .font(.largeTitle)
                .bold()

            Text("Review your work carefully before submitting it.")
                .font(.title3)
                .multilineTextAlignment(.center)
        }
        .padding(40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .alert("Double-Check Your Work", isPresented: $showingDoubleCheck) {
            Button("Double-Check Complete") {
                showingDoubleCheck = false
            }
        } message: {
            Text("Read each requirement again and verify that your answer is complete.")
        }
    }
}
