//
//  FetchTasksUseCase.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Combine

@MainActor
struct FetchTasksUseCase {
    private let repository: any TaskRepositoryProtocol

    init(repository: any TaskRepositoryProtocol) {
        self.repository = repository
    }

    var publisher: AnyPublisher<[FocusTask], Never> {
        repository.tasksPublisher
    }

    func execute() throws -> [FocusTask] {
        try repository.fetchTasks()
    }
}
