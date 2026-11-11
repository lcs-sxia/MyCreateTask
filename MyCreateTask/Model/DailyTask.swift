import Foundation

struct DailyTask: Identifiable, Hashable {

    // MARK: - Stored properties

    let id: UUID
    let title: String
    var isCompleted: Bool

    // MARK: - Initializer

    init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}

extension DailyTask {

    // MARK: - Sample data

    static let sampleTasks: [DailyTask] = [
        DailyTask(title: "Pack a lunch"),
        DailyTask(title: "Bring water"),
        DailyTask(title: "Finish homework")
    ]
}
