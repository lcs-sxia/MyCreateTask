import SwiftUI

struct DanceGamesView: View {

    // MARK: - Stored properties

    @State private var viewModel = DanceGamesViewModel()

    // MARK: - Computed properties

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Dance Games")
                    .font(.largeTitle)
                    .bold()

                Text("Choose a movement game for a group.")
                    .foregroundStyle(.secondary)

                ForEach(viewModel.games) { game in
                    VStack(alignment: .leading, spacing: 8) {
                        Label(game.name, systemImage: "figure.dance")
                            .font(.headline)

                        Text(game.summary)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.quaternary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                Spacer()
            }
        }
        .padding()
    }
}
