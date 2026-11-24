//
//  DanceGamesView.swift
//  MyCreateTask
//
//  Created on 2026-11-10.
//  AI Acknowledgment: GitHub Copilot was used to assist with SwiftUI implementation, refactoring, and debugging. All code behavior and outputs were reviewed and verified by the student.
//

import SwiftUI
import Combine

struct DanceGamesView: View {

    // MARK: - Stored properties

    @State private var viewModel = DanceGamesViewModel()
    // This optional value holds the activity chosen by the random button.
    @State private var randomlySelectedGame: DanceGame?

    // MARK: - Computed properties

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                danceGamesHeader
                controlBar
                danceActivitiesSection
            }
            .padding(.horizontal, 28)
            .padding(.top, 16)
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .fontDesign(.rounded)
        .navigationTitle("Dance Games")
        .navigationDestination(item: $randomlySelectedGame) { game in
            DanceGameDetailView(game: game, viewModel: viewModel)
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            viewModel.tickTimer()
        }
    }

    // MARK: - Views

    // This header introduces the Dance Games screen.
    private var danceGamesHeader: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Dance Games")
                .font(.largeTitle.weight(.bold))

            Text("Choose a movement game for a group.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    // This section shows an empty state or the filtered activity cards.
    @ViewBuilder
    private var danceActivitiesSection: some View {
        if viewModel.filteredGames.isEmpty {
            VStack(spacing: 8) {
                Image(systemName: "music.note")
                    .font(.title)
                    .foregroundStyle(.secondary)

                Text("No activities match the selected category and energy level.")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, minHeight: 180)
        } else {
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ],
                spacing: 12
            ) {
                ForEach(viewModel.filteredGames) { game in
                    NavigationLink {
                        DanceGameDetailView(game: game, viewModel: viewModel)
                    } label: {
                        danceCard(game)
                    }
                    .buttonStyle(.plain)
                    .contentShape(Rectangle())
                }
            }
        }
    }

    private var controlBar: some View {
        HStack(alignment: .bottom, spacing: 16) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    Text("Category:")
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(.secondary)

                    categoryPill(title: "All", category: nil)
                    ForEach(DanceGameCategory.allCases) { category in
                        categoryPill(title: category.rawValue, category: category)
                    }
                }

                HStack(spacing: 8) {
                    Text("Energy:")
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(.secondary)

                    energyPill(title: "All", energy: nil)
                    energyPill(title: "Low", energy: .low)
                    energyPill(title: "Medium", energy: .medium)
                    energyPill(title: "High", energy: .high)
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 8) {
                Text("\(viewModel.filteredGames.count) Activities")
                    .font(.caption.weight(.bold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(.blue.opacity(0.12))
                    .foregroundStyle(.blue)
                    .clipShape(Capsule())

                Button("Random Activity", systemImage: "shuffle") {
                    randomlySelectedGame = viewModel.filteredGames.randomElement()
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
                .disabled(viewModel.filteredGames.isEmpty)
                .opacity(viewModel.filteredGames.isEmpty ? 0.5 : 1.0)
            }
        }
    }

    private func categoryPill(title: String, category: DanceGameCategory?) -> some View {
        let isSelected = viewModel.selectedCategory == category

        return Button {
            viewModel.selectedCategory = category
        } label: {
            Text(title)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .frame(minHeight: 34)
                .background(isSelected ? .blue : Color.primary.opacity(0.06), in: Capsule())
        }
        .buttonStyle(.plain)
        .clipShape(Capsule())
    }

    private func energyPill(title: String, energy: DanceGameEnergy?) -> some View {
        let isSelected = viewModel.selectedEnergy == energy

        return Button {
            viewModel.selectedEnergy = energy
        } label: {
            Text(title)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .frame(minHeight: 34)
                .background(isSelected ? .orange : Color.primary.opacity(0.06), in: Capsule())
        }
        .buttonStyle(.plain)
        .clipShape(Capsule())
    }

    private func danceCard(_ game: DanceGame) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 8) {
                Text(game.name)
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 6) {
                Text(game.category.rawValue)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.cyan)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(.blue.opacity(0.28), in: Capsule())

                Text(shortEnergyName(game.energy))
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(.orange)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 5)
                    .background(.orange.opacity(0.15), in: Capsule())
            }

            Text(game.description)
                .font(.subheadline)
                .foregroundStyle(.primary.opacity(0.88))
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 8) {
                Label("\(game.duration) sec", systemImage: "clock.fill")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(.blue.opacity(0.13), in: Capsule())

                Label(game.groupSize, systemImage: "person.2")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 128, alignment: .topLeading)
        .padding(12)
        .background(.quaternary.opacity(0.7), in: RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.secondary.opacity(0.12), lineWidth: 1)
        }
    }

    private func shortEnergyName(_ energy: DanceGameEnergy) -> String {
        switch energy {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }

    struct DanceGameDetailView: View {

        // MARK: - Stored properties

        let game: DanceGame
        let viewModel: DanceGamesViewModel

        // MARK: - Computed properties

        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(game.name)
                        .font(.largeTitle.weight(.bold))

                    HStack(spacing: 6) {
                        badge(game.category.rawValue, tint: .blue)
                        badge(shortEnergyName(game.energy), tint: .orange)
                    }

                    Text(game.description)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }

                HStack(spacing: 12) {
                    statCard(title: "Duration", value: "\(game.duration) sec", icon: "clock")
                    statCard(title: "Players", value: game.groupSize, icon: "person.2")
                    statCard(title: "Energy Level", value: shortEnergyName(game.energy), icon: "bolt")
                }
                .frame(height: 78)

                HStack(alignment: .top, spacing: 20) {
                    howToPlayCard
                        .frame(maxWidth: .infinity, alignment: .topLeading)

                    VStack(alignment: .leading, spacing: 12) {
                        roundTimerCard
                            .frame(maxWidth: .infinity, alignment: .topLeading)

                        classroomTipCard
                            .frame(maxWidth: .infinity, alignment: .topLeading)
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
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                viewModel.tickTimer()
            }
        }

        // MARK: - Views

        private func statCard(title: String, value: String, icon: String) -> some View {
            VStack(alignment: .leading, spacing: 6) {
                Label(title, systemImage: icon)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)

                Text(value)
                    .font(.title3.bold())
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(12)
            .background(.quaternary.opacity(0.7), in: RoundedRectangle(cornerRadius: 12))
        }

        private var howToPlayCard: some View {
            VStack(alignment: .leading, spacing: 16) {
                Label("How to Play", systemImage: "list.number")
                    .font(.headline)
                    .foregroundStyle(.tint)

                ForEach(Array(game.steps.enumerated()), id: \.offset) { step in
                    HStack(alignment: .top, spacing: 12) {
                        Text("\(step.offset + 1)")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.primary)
                            .frame(width: 24, height: 24)
                            .background(.tint, in: Circle())

                        Text(step.element)
                            .font(.body)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(20)
            .background(.tint.opacity(0.07), in: RoundedRectangle(cornerRadius: 14))
        }

        private var roundTimerCard: some View {
            VStack(spacing: 10) {
                Label("Round Timer", systemImage: "timer")
                    .font(.headline)

                Text(viewModel.timerText(for: game))
                    .font(.system(size: 56, weight: .bold, design: .rounded))
                    .monospacedDigit()

                if viewModel.isComplete(game) {
                    Text("Time is up!")
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(.green)
                }

                HStack(spacing: 8) {
                    Button(viewModel.isRunning(game) ? "Pause" : "Start", systemImage: viewModel.isRunning(game) ? "pause.fill" : "play.fill") {
                        if viewModel.isRunning(game) {
                            viewModel.pauseTimer(for: game)
                        } else {
                            viewModel.startTimer(for: game)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.small)

                    Button("Reset", systemImage: "arrow.counterclockwise") {
                        viewModel.resetTimer(for: game)
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.small)
                }
            }
            .frame(maxWidth: .infinity, alignment: .top)
            .padding(16)
            .background(.blue.opacity(0.08), in: RoundedRectangle(cornerRadius: 14))
        }

        private var classroomTipCard: some View {
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "lightbulb")
                    .foregroundStyle(.orange)

                VStack(alignment: .leading, spacing: 3) {
                    Text("Classroom Tip")
                        .font(.subheadline.weight(.bold))
                    Text(game.classroomTip)
                        .font(.subheadline)
                        .foregroundStyle(.primary.opacity(0.88))
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(10)
            .background(.orange.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
        }

        private func badge(_ title: String, tint: Color) -> some View {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(tint)
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(tint.opacity(0.12), in: Capsule())
        }

        private func shortEnergyName(_ energy: DanceGameEnergy) -> String {
            switch energy {
            case .low:
                return "Low"
            case .medium:
                return "Medium"
            case .high:
                return "High"
            }
        }
    }
}
