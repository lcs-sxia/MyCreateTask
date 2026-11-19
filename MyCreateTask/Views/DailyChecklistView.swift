import SwiftUI

struct DailyChecklistView: View {

    // MARK: - Stored properties

    @State private var viewModel = DailyChecklistViewModel()
    @State private var newTaskTitle: String = ""
    @State private var showingAddTaskSheet: Bool = false
    @FocusState private var isAddTaskFieldFocused: Bool

    private let quickSuggestions: [String] = [
        "Practice Multiplication",
        "Read French Book",
        "Sign Student Agenda",
        "Clean Up Workspace"
    ]

    // MARK: - Computed properties

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Daily Checklist")
                    .font(.largeTitle.weight(.bold))

                Text("Plan today's tasks and celebrate completed work.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                progressSummaryCard

                if viewModel.tasks.isEmpty {
                    emptyState
                } else {
                    taskGrid
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 28)
            .padding(.top, 16)
            .padding(.bottom, 16)
            .fontDesign(.rounded)
        }
        .navigationTitle("Daily Checklist")
        .sheet(isPresented: $showingAddTaskSheet) {
            addTaskSheet
        }
    }

    // MARK: - Views

    private var progressSummaryCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(viewModel.completedTaskCount) of \(viewModel.tasks.count) Completed")
                        .font(.title2.weight(.bold))

                    Text(progressSubtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("\(completionPercentage)%")
                    .font(.headline.weight(.bold))
                    .foregroundStyle(.green)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(.green.opacity(0.14), in: Capsule())
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.green.opacity(0.14))

                    Capsule()
                        .fill(.green)
                        .frame(
                            width: geometry.size.width * viewModel.completionProgress
                        )
                }
            }
            .frame(height: 14)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Completion progress")
            .accessibilityValue("\(completionPercentage) percent")

            HStack(spacing: 10) {
                Button("New Task", systemImage: "plus") {
                    newTaskTitle = ""
                    showingAddTaskSheet = true
                }
                .buttonStyle(.borderedProminent)

                Button("Clear Completed", systemImage: "checkmark.circle") {
                    viewModel.clearCompletedTasks()
                }
                .buttonStyle(.bordered)
                .disabled(viewModel.completedTaskCount == 0)

                Button("Reset Defaults", systemImage: "arrow.counterclockwise") {
                    viewModel.resetDefaults()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding(18)
        .background(.green.opacity(0.08), in: RoundedRectangle(cornerRadius: 18))
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(.green.opacity(0.2), lineWidth: 1)
        }
    }

    private var addTaskSheet: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("New Task")
                    .font(.title2.weight(.bold))

                Spacer()

                Button("Cancel") {
                    showingAddTaskSheet = false
                }
                .buttonStyle(.bordered)
                .keyboardShortcut(.cancelAction)
            }

            TextField("What would you like to accomplish?", text: $newTaskTitle)
                .textFieldStyle(.roundedBorder)
                .focused($isAddTaskFieldFocused)
                .onSubmit {
                    addTask()
                }

            Text("Quick suggestions")
                .font(.headline)

            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 8),
                    GridItem(.flexible(), spacing: 8)
                ],
                spacing: 8
            ) {
                ForEach(quickSuggestions, id: \.self) { suggestion in
                    Button(suggestion) {
                        newTaskTitle = suggestion
                        isAddTaskFieldFocused = true
                    }
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity)
                }
            }

            Button("Add Task", systemImage: "plus") {
                addTask()
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
            .disabled(newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding(.horizontal, 28)
        .padding(.vertical, 16)
        .frame(width: 440)
        .fontDesign(.rounded)
        .onAppear {
            isAddTaskFieldFocused = true
        }
    }

    private var taskGrid: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: 14),
                GridItem(.flexible(), spacing: 14)
            ],
            spacing: 14
        ) {
            ForEach(viewModel.tasks) { task in
                taskCard(for: task)
            }
        }
    }

    private func taskCard(for task: DailyTask) -> some View {
        HStack(spacing: 10) {
            Button {
                viewModel.toggleTask(task)
            } label: {
                HStack(spacing: 10) {
                    Image(
                        systemName: task.isCompleted
                            ? "checkmark.circle.fill"
                            : "circle"
                    )
                    .font(.title3)
                    .foregroundStyle(task.isCompleted ? .green : .secondary)

                    Text(task.title)
                        .font(.headline)
                        .foregroundStyle(
                            task.isCompleted ? .secondary : .primary
                        )
                        .strikethrough(task.isCompleted)
                        .multilineTextAlignment(.leading)

                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity, minHeight: 52, alignment: .leading)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            Button("Delete", systemImage: "trash") {
                viewModel.delete(task)
            }
            .labelStyle(.iconOnly)
            .foregroundStyle(.red)
            .help("Delete \(task.title)")
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            task.isCompleted
                ? Color.green.opacity(0.1)
                : Color.blue.opacity(0.08),
            in: RoundedRectangle(cornerRadius: 16)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    task.isCompleted
                        ? Color.green.opacity(0.22)
                        : Color.blue.opacity(0.14),
                    lineWidth: 1
                )
        }
    }

    private var emptyState: some View {
        VStack(spacing: 10) {
            Image(systemName: "checkmark.seal")
                .font(.system(size: 38))
                .foregroundStyle(.green)

            Text("All clear!")
                .font(.title2.weight(.bold))

            Text("Add a new task or reset the defaults to keep your day on track.")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Button("Reset Defaults", systemImage: "arrow.counterclockwise") {
                viewModel.resetDefaults()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity)
        .padding(32)
        .background(.green.opacity(0.08), in: RoundedRectangle(cornerRadius: 18))
    }

    // MARK: - Functions

    private var completionPercentage: Int {
        Int((viewModel.completionProgress * 100).rounded())
    }

    private var progressSubtitle: String {
        let totalTasks: Int = viewModel.tasks.count
        let completedTasks: Int = viewModel.completedTaskCount

        if totalTasks > 0 && completedTasks == totalTasks {
            return "All tasks complete! Great job!"
        }

        if totalTasks == 0 {
            return "Add a task to get started."
        }

        return "Keep going—you are building great habits!"
    }

    private func addTask() {
        viewModel.addTask(title: newTaskTitle)
        if !newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            newTaskTitle = ""
            showingAddTaskSheet = false
        }
    }
}

#Preview {
    NavigationStack {
        DailyChecklistView()
    }
}
