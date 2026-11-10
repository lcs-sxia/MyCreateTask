import SwiftUI

struct DailyChecklistView: View {

    // MARK: - Stored properties

    @Environment(\.dismiss) private var dismiss
    @State private var packedLunch: Bool = false
    @State private var packedWater: Bool = false
    @State private var finishedHomework: Bool = false

    // MARK: - Computed properties

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Button("Home", systemImage: "house") {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    Spacer()
                }

                Text("Daily Checklist")
                    .font(.largeTitle)
                    .bold()

                Toggle("Pack a lunch", isOn: $packedLunch)
                Toggle("Bring water", isOn: $packedWater)
                Toggle("Finish homework", isOn: $finishedHomework)

                Spacer()
            }
        }
        .padding()
    }
}
