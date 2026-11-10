import SwiftUI

struct RecessGameGuideView: View {

    // MARK: - Stored properties

    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = RecessGameViewModel()
    @State private var playerCount = 3

    // MARK: - Computed properties

    var body: some View {
        let matchingGames = viewModel.findGamesForGroup(playerCount: playerCount)

        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Button("Home", systemImage: "house") {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    Spacer()
                }

                Text("Recess Game Guide")
                    .font(.largeTitle)
                    .bold()

                Text("Games for physical playground play")
                    .font(.title3)
                    .foregroundStyle(.secondary)

                Text("🏃 Physical Playground Game")
                    .font(.headline)
                    .foregroundStyle(.tint)

                Stepper("Players: \(playerCount)", value: $playerCount, in: 1...10)

                if matchingGames.isEmpty {
                    Text("No games match that group size.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(matchingGames) { game in
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

                Spacer()
            }
        }
        .padding()
    }
}
