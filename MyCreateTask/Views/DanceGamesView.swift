import SwiftUI
import Combine

struct DanceGamesView: View {

    // MARK: - Stored properties

    @State private var viewModel = DanceGamesViewModel()

    // MARK: - Computed properties

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Dance Games")
                    .font(.largeTitle.weight(.bold))

                Text("Choose a movement game for a group.")
                    .foregroundStyle(.secondary)

                Picker("Category", selection: $viewModel.selectedCategory) {
                    Text("All Games").tag(nil as DanceGameCategory?)
                    ForEach(DanceGameCategory.allCases) { category in
                        Text(category.rawValue).tag(category as DanceGameCategory?)
                    }
                }
                .pickerStyle(.segmented)

                Picker("Energy", selection: $viewModel.selectedEnergy) {
                    Text("All Energy").tag(nil as DanceGameEnergy?)
                    ForEach(DanceGameEnergy.allCases) { energy in
                        Text(energy.rawValue).tag(energy as DanceGameEnergy?)
                    }
                }
                .pickerStyle(.menu)

                if viewModel.selectedGameID != nil {
                    timerCard
                }

                ForEach(viewModel.filteredGames) { game in
                    VStack(alignment: .leading, spacing: 8) {
                        Button {
                            viewModel.selectGame(game)
                        } label: {
                            Label(game.name, systemImage: "music.note")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .buttonStyle(.plain)

                        Text(game.summary)
                            .foregroundStyle(.secondary)

                        HStack {
                            Label("\(game.duration) sec", systemImage: "clock")
                            Label(game.groupSize, systemImage: "person.2")
                            Text(game.energy.rawValue)
                        }
                        .font(.caption)
                        .foregroundStyle(.secondary)

                        Text("Steps")
                            .font(.headline)

                        ForEach(Array(game.instructions.enumerated()), id: \.offset) { instruction in
                            Label(instruction.element, systemImage: "\(instruction.offset + 1).circle")
                                .font(.subheadline)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.quaternary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                Spacer()
            }
            .fontDesign(.rounded)
        }
        .padding()
        .navigationTitle("Dance Games")
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            viewModel.tickTimer()
        }
    }

    // MARK: - Views

    private var timerCard: some View {
        VStack(spacing: 12) {
            Text("Active Break Timer")
                .font(.headline)

            Text(viewModel.timerText)
                .font(.system(size: 44, weight: .bold, design: .rounded))
                .monospacedDigit()

            HStack {
                Button("Start", systemImage: "play.fill") {
                    viewModel.startTimer()
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isTimerRunning)

                Button("Pause", systemImage: "pause.fill") {
                    viewModel.pauseTimer()
                }
                .buttonStyle(.bordered)
                .disabled(!viewModel.isTimerRunning)

                Button("Reset", systemImage: "arrow.counterclockwise") {
                    viewModel.resetTimer()
                }
                .buttonStyle(.bordered)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.blue.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
