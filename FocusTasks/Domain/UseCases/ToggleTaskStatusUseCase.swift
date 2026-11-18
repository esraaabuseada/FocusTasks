//
//  ToggleTaskStatusUseCase.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Foundation

@MainActor
struct ToggleTaskStatusUseCase {
    private let repository: any TaskRepositoryProtocol
    private let dateProvider: any DateProviderProtocol

    init(repository: any TaskRepositoryProtocol, dateProvider: any DateProviderProtocol) {
        self.repository = repository
        self.dateProvider = dateProvider
    }

    func execute(_ task: FocusTask) throws {
        var updated = task
        updated.isCompleted.toggle()
        updated.completedAt = updated.isCompleted ? dateProvider.now : nil
        try repository.update(updated)
    }
}
