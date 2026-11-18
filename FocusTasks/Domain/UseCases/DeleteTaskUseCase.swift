//
//  DeleteTaskUseCase.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Foundation

@MainActor
struct DeleteTaskUseCase {
    private let repository: any TaskRepositoryProtocol

    init(repository: any TaskRepositoryProtocol) {
        self.repository = repository
    }

    func execute(id: UUID) throws {
        try repository.delete(id: id)
    }
}
