import SwiftUI

struct LearningAssistantView: View {

    // MARK: - Stored properties

    @Environment(\.dismiss) private var dismiss
    @State private var answer: String = ""
    @State private var showingSafetyInspection: Bool = false
    @State private var answerIsCorrect: Bool = false

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

                TextField("Your answer", text: $answer)
                    .textFieldStyle(.roundedBorder)

                Button("Launch Rocket") {
                    showingSafetyInspection = true
                }
                .buttonStyle(.borderedProminent)

                if answerIsCorrect {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("+10 Points")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.green)

                        Text("⭐ Star Badge")
                            .font(.title2)
                    }
                    .padding()
                    .background(.green.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                Spacer()
            }
        }
        .padding()
        .alert("Safety Inspection / Double-Check", isPresented: $showingSafetyInspection) {
            Button("Confirm Answer") {
                checkAnswer()
            }
        } message: {
            Text("Check your multiplication answer carefully before launching the rocket.")
        }
    }

    // MARK: - Functions

    private func checkAnswer() {
        let trimmedAnswer: String = answer.trimmingCharacters(in: .whitespacesAndNewlines)

        if let submittedAnswer = Int(trimmedAnswer) {
            answerIsCorrect = submittedAnswer == 56
        } else {
            answerIsCorrect = false
        }
    }
}
