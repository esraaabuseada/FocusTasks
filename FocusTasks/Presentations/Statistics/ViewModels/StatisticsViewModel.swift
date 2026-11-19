//
//  StatisticsViewModel.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Combine
import Foundation

struct StatisticsSnapshot: Equatable, Sendable {
    var total = 0
    var completed = 0
    var pending = 0
    var overdue = 0
    var byPriority: [TaskPriority: Int] = [:]

    var completionRate: Double {
        total == 0 ? 0 : Double(completed) / Double(total)
    }

    static let empty = StatisticsSnapshot()
}

@MainActor
final class StatisticsViewModel: BaseViewModel {
    @Published private(set) var snapshot: StatisticsSnapshot = .empty

    private let fetchTasksUseCase: FetchTasksUseCase
    private let dateProvider: any DateProviderProtocol

    init(fetchTasksUseCase: FetchTasksUseCase, dateProvider: any DateProviderProtocol) {
        self.fetchTasksUseCase = fetchTasksUseCase
        self.dateProvider = dateProvider
        super.init()
        bind()
    }

    private func bind() {
        let provider = dateProvider
        fetchTasksUseCase.publisher
            .map { tasks in Self.makeSnapshot(from: tasks, now: provider.now) }
            .assign(to: &$snapshot)
    }

    nonisolated private static func makeSnapshot(from tasks: [FocusTask], now: Date) -> StatisticsSnapshot {
        let completed = tasks.filter(\.isCompleted).count
        return StatisticsSnapshot(
            total: tasks.count,
            completed: completed,
            pending: tasks.count - completed,
            overdue: tasks.filter { $0.isOverdue(now: now) }.count,
            byPriority: Dictionary(grouping: tasks, by: \.priority).mapValues(\.count)
        )
    }
}
