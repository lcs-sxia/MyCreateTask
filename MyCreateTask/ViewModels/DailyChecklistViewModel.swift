import Foundation
import Observation

@Observable
final class DailyChecklistViewModel {

    // MARK: - Stored properties

    private(set) var tasks: [DailyTask] = DailyTask.sampleTasks

    // MARK: - Computed properties

    var completedTaskCount: Int {
        var count: Int = 0

        for task in tasks where task.isCompleted {
            count += 1
        }

        return count
    }

    var completionProgress: Double {
        guard !tasks.isEmpty else {
            return 0
        }

        return Double(completedTaskCount) / Double(tasks.count)
    }

    // MARK: - Functions

    func toggleTask(_ task: DailyTask) {
        var taskIndex: Int?

        for index in tasks.indices {
            if tasks[index].id == task.id {
                taskIndex = index
                break
            }
        }

        guard let taskIndex else {
            return
        }

        tasks[taskIndex].isCompleted.toggle()
    }

    func addTask(title: String) {
        let trimmedTitle: String = title.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedTitle.isEmpty else {
            return
        }

        tasks.append(DailyTask(title: trimmedTitle))
    }

    func deleteTasks(at offsets: IndexSet) {
        let sortedOffsets: [Int] = offsets.sorted(by: >)

        for offset in sortedOffsets {
            tasks.remove(at: offset)
        }
    }

    func delete(_ task: DailyTask) {
        tasks.removeAll { currentTask in
            currentTask.id == task.id
        }
    }
}
