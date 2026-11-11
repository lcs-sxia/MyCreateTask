import SwiftUI

struct LearningAssistantView: View {

    // MARK: - Stored properties

    @Environment(\.dismiss) private var dismiss
    @State private var userAnswer: String = ""
    @State private var showDoubleCheckAlert: Bool = false
    @State private var showResult: Bool = false
    @State private var isCorrect: Bool = false
    @State private var showHint: Bool = false

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

                Image(systemName: "rocket.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.tint)

                Text("Rocket Math Launch")
                    .font(.largeTitle)
                    .bold()

                Text("7 × 8 = ?")
                    .font(.system(size: 48))

                TextField("Your answer", text: $userAnswer)
                    .textFieldStyle(.roundedBorder)

                Button("Launch Rocket") {
                    showDoubleCheckAlert = true
                }
                .buttonStyle(.borderedProminent)

                if showResult {
                    if isCorrect {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Perfect Launch! 🌌")
                                .font(.title)
                                .bold()
                                .foregroundStyle(.green)

                            Text("+10 Points 🪙")
                                .font(.title2)

                            Text("⭐ Star Badge Unlocked!")
                                .font(.title2)
                        }
                        .padding()
                        .background(.green.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    } else {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Oops! Try Again!")
                                .font(.title)
                                .bold()
                                .foregroundStyle(.orange)

                            Button("[ 💡 Show Hint ]") {
                                showHint.toggle()
                            }
                            .buttonStyle(.bordered)

                            if showHint {
                                Text("Hint: 7 x 8 means 7 added 8 times (56)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding()
                        .background(.orange.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }

                Spacer()
            }
        }
        .padding()
        .alert("Safety Inspection", isPresented: $showDoubleCheckAlert) {
            Button("Re-check", role: .cancel) {
            }
            Button("I'm Sure! Launch") {
                checkAnswer()
            }
        } message: {
            Text("Safety Inspection: Did you double check your fuel calculation?")
        }
    }

    // MARK: - Functions

    private func checkAnswer() {
        let trimmedAnswer: String = userAnswer.trimmingCharacters(in: .whitespacesAndNewlines)

        if let submittedAnswer = Int(trimmedAnswer) {
            isCorrect = 7 * 8 == submittedAnswer
        } else {
            isCorrect = false
        }

        showResult = true
        showHint = false
    }
}
