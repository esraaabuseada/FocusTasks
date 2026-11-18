//
//  FocusTask.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Foundation

struct FocusTask: Identifiable, Equatable, Hashable, Sendable {
    let id: UUID
    var title: String
    var notes: String
    var priority: TaskPriority
    var isCompleted: Bool
    var dueDate: Date?
    let createdAt: Date
    var completedAt: Date?

    init(
        id: UUID = UUID(),
        title: String,
        notes: String = "",
        priority: TaskPriority = .medium,
        isCompleted: Bool = false,
        dueDate: Date? = nil,
        createdAt: Date = Date(),
        completedAt: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.notes = notes
        self.priority = priority
        self.isCompleted = isCompleted
        self.dueDate = dueDate
        self.createdAt = createdAt
        self.completedAt = completedAt
    }

    /// متأخرة = ليها موعد قبل بداية النهارده وماخلصتش.
    func isOverdue(now: Date, calendar: Calendar = .current) -> Bool { //////
        guard let dueDate, !isCompleted else { return false }
        return dueDate < calendar.startOfDay(for: now)
    }
}
