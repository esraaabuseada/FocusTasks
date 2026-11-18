//
//   UpdateTaskUseCase.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Foundation

@MainActor
struct UpdateTaskUseCase {
    private let repository: any TaskRepositoryProtocol

    init(repository: any TaskRepositoryProtocol) {
        self.repository = repository
    }

    func execute(_ task: FocusTask) throws {
        var updated = task
        updated.title = try task.title.validatedTaskTitle()
        updated.notes = task.notes.trimmed
        try repository.update(updated)
    }
}
