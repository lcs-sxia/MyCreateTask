//
//  DailyTask.swift
//  MyCreateTask
//
//  Created by Steven Xia on 2026-11-11.
//  This code was generated using GitHub Copilot.
//

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
        DailyTask(title: "Complete Math Worksheet"),
        DailyTask(title: "Read for 20 Minutes"),
        DailyTask(title: "Organize Study Desk"),
        DailyTask(title: "Pack Tomorrow's Backpack")
    ]
}
