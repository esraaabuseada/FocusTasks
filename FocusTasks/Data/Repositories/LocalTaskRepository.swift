//
//  LocalTaskRepository.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Combine
import Foundation

/////////////////////////////////////////
@MainActor
final class LocalTaskRepository: TaskRepositoryProtocol {
    private let storage: any TaskStorageProtocol
    private let subject: CurrentValueSubject<[FocusTask], Never>

    init(storage: any TaskStorageProtocol) {
        self.storage = storage
        let initial = (try? storage.load())?.map { $0.toDomain() } ?? []
        self.subject = CurrentValueSubject(initial)
    }

    var tasksPublisher: AnyPublisher<[FocusTask], Never> {
        subject.eraseToAnyPublisher()
    }

    func fetchTasks() throws -> [FocusTask] {
        subject.value
    }

    func add(_ task: FocusTask) throws {
        try persist(subject.value + [task])
    }

    func update(_ task: FocusTask) throws {
        var current = subject.value
        guard let index = current.firstIndex(where: { $0.id == task.id }) else {
            throw AppError.taskNotFound
        }
        current[index] = task
        try persist(current)
    }

    func delete(id: UUID) throws {
        var current = subject.value
        guard current.contains(where: { $0.id == id }) else {
            throw AppError.taskNotFound
        }
        current.removeAll { $0.id == id }
        try persist(current)
    }

    /// بنحفظ الأول، ولو نجح بنبعت القائمة الجديدة. لو الحفظ فشل الـ state القديم بيفضل زي ما هو.
    private func persist(_ tasks: [FocusTask]) throws {
        try storage.save(tasks.map(TaskStorageDTO.init))
        subject.send(tasks)
    }
}
