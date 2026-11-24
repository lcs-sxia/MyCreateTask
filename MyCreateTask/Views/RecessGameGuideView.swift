//
//  RecessGameGuideView.swift
//  MyCreateTask
//
//  Created by Steven Xia on 2026-11-10.
//  This code was generated using GitHub Copilot.
//

import SwiftUI

struct RecessGameGuideView: View {

    // MARK: - Stored properties

    @State private var viewModel = RecessGameViewModel()
    // This optional value stores the game selected by the random button.
    @State private var randomlySelectedGame: RecessGame?

    // MARK: - Computed properties

    var body: some View {
        @Bindable var viewModel = viewModel

        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 16) {
                header
                searchBar
                controlBar
                gamesGridSection
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(.horizontal, 28)
            .padding(.top, 20)
            .padding(.bottom, 28)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .fontDesign(.rounded)
        .navigationTitle("Recess Game Guide")
        .navigationDestination(item: $randomlySelectedGame) { game in
            RecessGameDetailView(game: game)
        }
    }

    // MARK: - Views

    // This section shows either an empty state or the matching game cards.
    @ViewBuilder
    private var gamesGridSection: some View {
        if viewModel.filteredGames.isEmpty {
            VStack(spacing: 8) {
                Image(systemName: "figure.run")
                    .font(.title)
                    .foregroundStyle(.secondary)

                if viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Text("No games match the selected player count and category.")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                } else {
                    Text("No games match your search")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 180)
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
            .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Recess Game Guide")
                .font(.largeTitle.weight(.bold))

            Text("Filter playground games by player count and activity type.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var searchBar: some View {
        @Bindable var viewModel = viewModel

        return HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField("Search games by keyword...", text: $viewModel.searchText)
                .textFieldStyle(.plain)
                .accessibilityLabel("Search games by keyword")

            if !viewModel.searchText.isEmpty {
                Button("Clear search", systemImage: "xmark.circle.fill") {
                    viewModel.searchText = ""
                }
                .labelStyle(.iconOnly)
                .buttonStyle(.plain)
                .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 11)
        .background(.quaternary.opacity(0.7), in: Capsule())
        .overlay {
            Capsule()
                .stroke(.secondary.opacity(0.12), lineWidth: 1)
        }
    }

    private var controlBar: some View {
        @Bindable var viewModel = viewModel

        return HStack(alignment: .bottom, spacing: 12) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    Text("Category:")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)

                    ForEach(viewModel.categories, id: \.self) { category in
                        categoryPill(
                            title: category,
                            isSelected: isCategorySelected(category)
                        ) {
                            viewModel.selectCategory(category)
                        }
                    }
                }

                HStack(spacing: 8) {
                    Text("Players:")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)

                    ForEach(RecessPlayerFilter.allCases) { filter in
                        playerPill(filter)
                    }
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 8) {
                Text("\(viewModel.filteredGames.count) Games")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(.blue.opacity(0.12), in: Capsule())

                Button("Random Game", systemImage: "shuffle") {
                    randomlySelectedGame = viewModel.filteredGames.randomElement()
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
                .disabled(viewModel.filteredGames.isEmpty)
                .opacity(viewModel.filteredGames.isEmpty ? 0.5 : 1.0)
            }
        }
    }

    private func categoryPill(
        title: String,
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(isSelected ? .purple : Color.primary.opacity(0.06), in: Capsule())
        }
        .buttonStyle(.plain)
        .contentShape(Capsule())
    }

    private func playerPill(_ filter: RecessPlayerFilter) -> some View {
        let isSelected = viewModel.selectedPlayerFilter == filter

        return Button {
            viewModel.selectedPlayerFilter = filter
        } label: {
            Text(filter.rawValue)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(isSelected ? .purple : Color.primary.opacity(0.06), in: Capsule())
        }
        .buttonStyle(.plain)
        .clipShape(Capsule())
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
                .foregroundStyle(.primary.opacity(0.88))
                .fixedSize(horizontal: false, vertical: true)

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
                statBadge(
                    title: "Duration",
                    text: "\(game.estimatedDuration) min",
                    icon: "clock"
                )
            }
            .frame(height: 112)

            HStack(alignment: .top, spacing: 16) {
                detailSection(title: "Rules", icon: "list.bullet") {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(Array(game.ruleSteps.enumerated()), id: \.offset) { step in
                            HStack(alignment: .top, spacing: 10) {
                                Text("\(step.offset + 1).")
                                    .font(.body.weight(.bold))
                                    .foregroundStyle(.primary)
                                    .frame(width: 24, alignment: .leading)

                                Text(step.element)
                                    .font(.body)
                                    .foregroundStyle(.primary)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)

                VStack(alignment: .leading, spacing: 16) {
                    detailSection(title: "Equipment", icon: "shippingbox") {
                        Text(game.equipment)
                            .font(.body.weight(.semibold))
                            .foregroundStyle(.primary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 7)
                            .background(.purple.opacity(0.12), in: Capsule())
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
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, 28)
        .padding(.top, 16)
        .padding(.bottom, 16)
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
                .foregroundStyle(.primary.opacity(0.88))
                .fixedSize(horizontal: false, vertical: true)
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
