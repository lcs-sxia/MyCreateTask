import SwiftUI

struct RecessGameGuideView: View {

    // MARK: - Stored properties

    @State private var viewModel = RecessGameViewModel()
    @State private var playerCount = 3

    // MARK: - Computed properties

    var body: some View {
        let matchingGames = viewModel.findGamesForGroup(playerCount: playerCount)

        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Recess Game Guide")
                    .font(.largeTitle)
                    .bold()

                Text("Games for physical playground play")
                    .font(.title3)
                    .foregroundStyle(.secondary)

                Text("🏃 Physical Playground Game (Real World Play)")
                    .font(.headline)
                    .foregroundStyle(.tint)

                Stepper("Players: \(playerCount)", value: $playerCount, in: 1...10)

                if matchingGames.isEmpty {
                    Text("No games match that group size.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(matchingGames) { game in
                        NavigationLink(destination: RecessGameDetailView(game: game)) {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text(game.name)
                                        .font(.headline)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.secondary)
                                }
                                Text(game.category)
                                    .font(.subheadline)
                                    .foregroundStyle(.tint)
                                Text(game.summary)
                                    .foregroundStyle(.secondary)
                                Text("Minimum players: \(game.minPlayers)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(.quaternary)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .buttonStyle(.plain)
                    }
                }

                Spacer()
            }
        }
        .padding()
        .navigationTitle("Recess Game Guide")
    }
}

struct RecessGameDetailView: View {

    // MARK: - Stored properties

    let game: RecessGame

    // MARK: - Computed properties

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(game.name)
                    .font(.largeTitle)
                    .bold()

                Text(game.category)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(.blue)
                    .clipShape(Capsule())

                Text("🏃 Physical Playground Game")
                    .font(.headline)
                    .foregroundStyle(.tint)

                Text(game.summary)
                    .font(.title3)

                detailSection(title: "Game Overview") {
                    detailRow(title: "Play Area", text: game.playArea)
                    detailRow(title: "Goal", text: game.goal)
                    detailRow(title: "Players", text: "At least \(game.minPlayers)")
                }

                detailSection(title: "Rules") {
                    Text("1. \(game.rules)")
                }

                detailSection(title: "Equipment") {
                    Text(game.equipment)
                }

                detailSection(title: "Safety") {
                    Text(game.safety)
                }
            }
        }
        .padding()
        .navigationTitle(game.name)
    }

    // MARK: - Functions

    @ViewBuilder
    private func detailSection<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2)
                .bold()
            content()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.quaternary)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func detailRow(title: String, text: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.headline)
            Text(text)
        }
    }
}
