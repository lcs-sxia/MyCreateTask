import SwiftUI

struct DailyChecklistView: View {

    // MARK: - Stored properties

    @State private var viewModel = DailyChecklistViewModel()
    @State private var newTaskTitle: String = ""

    // MARK: - Computed properties

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Daily Checklist")
                    .font(.largeTitle.weight(.bold))

                Text("\(viewModel.completedTaskCount)/\(viewModel.tasks.count) Completed")
                    .font(.headline)
                    .foregroundStyle(.secondary)

                ProgressView(value: viewModel.completionProgress)
                    .tint(.green)

                HStack {
                    TextField("Add a task", text: $newTaskTitle)
                        .textFieldStyle(.roundedBorder)

                    Button("Add", systemImage: "plus") {
                        viewModel.addTask(title: newTaskTitle)
                        newTaskTitle = ""
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }

                ForEach(viewModel.tasks) { task in
                    HStack(spacing: 12) {
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
                        .buttonStyle(.plain)

                        Button("Delete", systemImage: "trash") {
                            viewModel.delete(task)
                        }
                        .labelStyle(.iconOnly)
                        .foregroundStyle(.red)
                    }
                    .padding()
                    .background(.green.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                Spacer()
            }
            .fontDesign(.rounded)
        }
        .padding()
        .navigationTitle("Daily Checklist")
    }
}
