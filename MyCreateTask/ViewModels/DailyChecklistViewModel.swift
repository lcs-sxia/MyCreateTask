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
}
