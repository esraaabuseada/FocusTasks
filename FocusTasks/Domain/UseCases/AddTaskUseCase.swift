//
//  AddTaskUseCase.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Foundation

@MainActor
struct AddTaskUseCase {
    private let repository: any TaskRepositoryProtocol
    private let dateProvider: any DateProviderProtocol

    init(repository: any TaskRepositoryProtocol, dateProvider: any DateProviderProtocol) {
        self.repository = repository
        self.dateProvider = dateProvider
    }

    @discardableResult
    func execute(
        title: String,
        notes: String,
        priority: TaskPriority,
        dueDate: Date?
    ) throws -> FocusTask {
        let task = FocusTask(
            title: try title.validatedTaskTitle(),
            notes: notes.trimmed,
            priority: priority,
            dueDate: dueDate,
            createdAt: dateProvider.now
        )
        try repository.add(task)
        return task
    }
}
