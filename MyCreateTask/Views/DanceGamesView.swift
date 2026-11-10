import SwiftUI

struct DanceGamesView: View {

    // MARK: - Stored properties

    @Environment(\.dismiss) private var dismiss
    let danceGames: [String] = [
        "Freeze Dance",
        "Follow the Leader",
        "Dance Copycat"
    ]

    // MARK: - Computed properties

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button("Home") {
                dismiss()
            }
            .buttonStyle(.bordered)

            Text("Dance Games")
                .font(.largeTitle)
                .bold()

            Text("Choose a movement game for a group.")
                .foregroundStyle(.secondary)

            List(danceGames, id: \.self) { danceGame in
                Label(danceGame, systemImage: "figure.dance")
            }

            Spacer()
        }
        .padding(24)
        .frame(minWidth: 400, minHeight: 350)
    }
}
