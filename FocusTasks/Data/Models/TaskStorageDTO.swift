//
//  TaskStorageDTO.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Foundation

/// الشكل اللي بيتخزن فعلياً. منفصل عن الـ Domain Model عشان لو غيرنا الـ storage ما نأثرش على الـ Domain.
struct TaskStorageDTO: Codable, Sendable, Equatable {
    let id: UUID
    var title: String
    var notes: String
    var priorityRaw: String
    var isCompleted: Bool
    var dueDate: Date?
    let createdAt: Date
    var completedAt: Date?

    init(_ task: FocusTask) {
        id = task.id
        title = task.title
        notes = task.notes
        priorityRaw = task.priority.rawValue
        isCompleted = task.isCompleted
        dueDate = task.dueDate
        createdAt = task.createdAt
        completedAt = task.completedAt
    }

    func toDomain() -> FocusTask {
        FocusTask(
            id: id,
            title: title,
            notes: notes,
            priority: TaskPriority(rawValue: priorityRaw) ?? .medium,
            isCompleted: isCompleted,
            dueDate: dueDate,
            createdAt: createdAt,
            completedAt: completedAt
        )
    }
}
