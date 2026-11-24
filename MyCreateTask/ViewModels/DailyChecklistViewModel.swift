//
//  DailyChecklistViewModel.swift
//  MyCreateTask
//
//  Created by Steven Xia on 2026-11-11.
//  This code was generated using GitHub Copilot.
//

import Foundation
import Observation

@Observable
final class DailyChecklistViewModel {

    // MARK: - Stored properties

    private(set) var tasks: [DailyTask] = DailyTask.sampleTasks

    // MARK: - Computed properties

    var completedTaskCount: Int {
        countCompletedTasks(tasks: tasks)
    }

    var completionProgress: Double {
        guard !tasks.isEmpty else {
            return 0
        }

        return Double(completedTaskCount) / Double(tasks.count)
    }

    // MARK: - Functions

    func countCompletedTasks(tasks: [DailyTask]) -> Int {
        var count: Int = 0

        // Add one for each task that is marked complete.
        for task in tasks {
            if task.isCompleted {
                count += 1
            }
        }

        return count
    }

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
        var offsetArray: [Int] = []

        // Copy the requested positions, then sort them by hand from highest to lowest.
        for offset in offsets {
            offsetArray.append(offset)
        }
        offsetArray.sort()

        if !offsetArray.isEmpty {
            for index in stride(from: offsetArray.count - 1, through: 0, by: -1) {
                let offset: Int = offsetArray[index]
                if tasks.indices.contains(offset) {
                    tasks.remove(at: offset)
                }
            }
        }
    }

    func delete(_ task: DailyTask) {
        var remainingTasks: [DailyTask] = []

        // Keep every task except the task with the matching ID.
        for currentTask in tasks {
            if currentTask.id != task.id {
                remainingTasks.append(currentTask)
            }
        }

        tasks = remainingTasks
    }

    func clearCompletedTasks() {
        var remainingTasks: [DailyTask] = []

        // Keep only tasks that are not completed.
        for task in tasks {
            if !task.isCompleted {
                remainingTasks.append(task)
            }
        }

        tasks = remainingTasks
    }

    func resetDefaults() {
        tasks = DailyTask.sampleTasks
    }
}
