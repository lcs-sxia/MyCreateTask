import SwiftUI

struct DailyChecklistView: View {

    // MARK: - Stored properties

    @State private var viewModel = DailyChecklistViewModel()

    // MARK: - Computed properties

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Daily Checklist")
                    .font(.largeTitle)
                    .bold()

                Text("\(viewModel.completedTaskCount) of \(viewModel.tasks.count) tasks complete")
                    .foregroundStyle(.secondary)

                ForEach(viewModel.tasks) { task in
                    Button {
                        viewModel.toggleTask(task)
                    } label: {
                        Label(
                            task.title,
                            systemImage: task.isCompleted
                                ? "checkmark.square.fill"
                                : "square"
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .buttonStyle(.bordered)
                }

                Spacer()
            }
        }
        .padding()
    }
}
