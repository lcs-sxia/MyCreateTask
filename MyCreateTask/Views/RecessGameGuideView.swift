import SwiftUI

struct RecessGameGuideView: View {

    // MARK: - Stored properties

    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = RecessGameViewModel()
    @State private var playerCountText: String = ""

    // MARK: - Computed properties

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button("Home") {
                dismiss()
            }
            .buttonStyle(.bordered)

            Text("Recess Game Guide")
                .font(.largeTitle)
                .bold()

            Text("Games for physical playground play")
                .font(.title3)
                .foregroundStyle(.secondary)

            TextField("Number of players", text: $playerCountText)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: 260)

            if let playerCount = Int(playerCountText), playerCount > 0 {
                let matchingGames = viewModel.findGamesForGroup(playerCount: playerCount)

                if matchingGames.isEmpty {
                    Text("No games match that group size.")
                        .foregroundStyle(.secondary)
                } else {
                    List(matchingGames) { game in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(game.name)
                                .font(.headline)
                            Text("Minimum players: \(game.minPlayers)")
                            Text("Equipment: \(game.equipment)")
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            } else {
                Text("Enter a positive number of players to see matching games.")
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(24)
        .frame(minWidth: 500, minHeight: 450)
    }
}
