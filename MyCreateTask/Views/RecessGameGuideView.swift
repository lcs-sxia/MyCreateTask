import SwiftUI

struct RecessGameGuideView: View {

    // MARK: - Stored properties

    @State private var viewModel = RecessGameViewModel()
    @State private var randomlySelectedGame: RecessGame?

    // MARK: - Computed properties

    var body: some View {
        @Bindable var viewModel = viewModel

        VStack(alignment: .leading, spacing: 16) {
            header
            controlBar

            if viewModel.filteredGames.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "figure.run")
                        .font(.title)
                        .foregroundStyle(.secondary)

                    Text("No games match the selected player count and category.")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 14),
                        GridItem(.flexible(), spacing: 14)
                    ],
                    spacing: 14
                ) {
                    ForEach(viewModel.filteredGames) { game in
                        NavigationLink {
                            RecessGameDetailView(game: game)
                        } label: {
                            gameCard(game)
                        }
                        .buttonStyle(.plain)
                        .contentShape(Rectangle())
                    }
                }
            }
        }
        .frame(maxWidth: 1100, maxHeight: .infinity, alignment: .top)
        .padding(24)
        .fontDesign(.rounded)
        .navigationTitle("Recess Game Guide")
        .navigationDestination(item: $randomlySelectedGame) { game in
            RecessGameDetailView(game: game)
        }
    }

    // MARK: - Views

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Recess Game Guide")
                .font(.largeTitle.weight(.bold))

            Text("Filter playground games by player count and activity type.")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }

    private var controlBar: some View {
        @Bindable var viewModel = viewModel

        return HStack(spacing: 12) {
            Stepper(
                "Players: \(viewModel.playerCount)",
                value: $viewModel.playerCount,
                in: 1...10
            )
            .fixedSize()

            Divider()
                .frame(height: 28)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        categoryPill(
                            title: category,
                            isSelected: isCategorySelected(category)
                        ) {
                            viewModel.selectCategory(category)
                        }
                    }
                }
            }

            HStack(spacing: 8) {
                Text("\(viewModel.filteredGames.count) Games")
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(.secondary.opacity(0.1), in: Capsule())

                Button("Random Game", systemImage: "shuffle") {
                    randomlySelectedGame = viewModel.filteredGames.randomElement()
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
                .disabled(viewModel.filteredGames.isEmpty)
                .opacity(viewModel.filteredGames.isEmpty ? 0.5 : 1.0)
            }
        }
        .padding(8)
        .background(.quaternary.opacity(0.55), in: RoundedRectangle(cornerRadius: 16))
    }

    private func categoryPill(
        title: String,
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 10)
                .padding(.vertical, 7)
                .background(
                    isSelected ? Color.accentColor : Color.clear,
                    in: Capsule()
                )
        }
        .buttonStyle(.plain)
        .contentShape(Capsule())
    }

    private func isCategorySelected(_ category: String) -> Bool {
        if category == "All" {
            return viewModel.selectedCategory == nil
        }

        return viewModel.selectedCategory == category
    }

    private func minimumPlayersText(for game: RecessGame) -> String {
        let playerWord: String = game.minPlayers == 1 ? "player" : "players"
        return "Minimum \(game.minPlayers) \(playerWord)"
    }

    private func gameCard(_ game: RecessGame) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 8) {
                Text(game.name)
                    .font(.headline.weight(.bold))
                    .multilineTextAlignment(.leading)

                Spacer(minLength: 4)

                Image(systemName: "chevron.right")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)
            }

            Text(game.category)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tint)
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(.tint.opacity(0.12), in: Capsule())

            Text(game.summary)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)

            Label(
                minimumPlayersText(for: game),
                systemImage: "person.2"
            )
            .font(.caption.weight(.semibold))
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 128, alignment: .topLeading)
        .padding(12)
        .background(.quaternary.opacity(0.7), in: RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.secondary.opacity(0.12), lineWidth: 1)
        }
    }
}

struct RecessGameDetailView: View {

    // MARK: - Stored properties

    let game: RecessGame

    // MARK: - Computed properties

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text(game.name)
                    .font(.largeTitle.weight(.bold))

                Text(game.category)
                    .font(.headline)
                    .foregroundStyle(.tint)

                Text(game.summary)
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 12) {
                statBadge(title: "Play Area", text: game.playArea, icon: "map")
                statBadge(title: "Goal", text: game.goal, icon: "target")
                statBadge(
                    title: "Minimum Players",
                    text: "\(game.minPlayers)",
                    icon: "person.2"
                )
            }
            .frame(height: 112)

            HStack(alignment: .top, spacing: 16) {
                detailSection(title: "Rules", icon: "list.bullet") {
                    Text(game.rules)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)

                VStack(alignment: .leading, spacing: 16) {
                    detailSection(title: "Equipment", icon: "shippingbox") {
                        Text(game.equipment)
                    }

                    detailSection(
                        title: "Safety",
                        icon: "checkmark.shield",
                        tint: .orange
                    ) {
                        Text(game.safety)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
        }
        .frame(maxWidth: 1100, maxHeight: .infinity, alignment: .top)
        .padding(24)
        .fontDesign(.rounded)
        .navigationTitle(game.name)
    }

    // MARK: - Views

    private func statBadge(title: String, text: String, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Label(title, systemImage: icon)
                .font(.caption.weight(.bold))
                .foregroundStyle(.secondary)

            Text(text)
                .font(.subheadline)
                .lineLimit(3)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .padding(12)
        .background(.quaternary.opacity(0.7), in: RoundedRectangle(cornerRadius: 12))
    }

    private func detailSection<Content: View>(
        title: String,
        icon: String,
        tint: Color = .accentColor,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: icon)
                .font(.headline)
                .foregroundStyle(tint)

            content()
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            tint.opacity(tint == .orange ? 0.12 : 0.07),
            in: RoundedRectangle(cornerRadius: 14)
        )
    }
}

#Preview {
    NavigationStack {
        RecessGameGuideView()
    }
}
