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
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Button("Home", systemImage: "house") {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    Spacer()
                }

                Text("Dance Games")
                    .font(.largeTitle)
                    .bold()

                Text("Choose a movement game for a group.")
                    .foregroundStyle(.secondary)

                ForEach(danceGames, id: \.self) { danceGame in
                    Label(danceGame, systemImage: "figure.dance")
                }

                Spacer()
            }
        }
        .padding()
    }
}
