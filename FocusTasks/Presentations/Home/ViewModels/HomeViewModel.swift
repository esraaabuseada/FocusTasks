//
//  HomeViewModel.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Combine
import Foundation

@MainActor
final class HomeViewModel: BaseViewModel {
    @Published private(set) var tasks: [FocusTask] = []
    @Published private(set) var filteredTasks: [FocusTask] = []
    @Published var filter: TaskFilter = .all
    @Published var searchText: String = ""

    private let fetchTasksUseCase: FetchTasksUseCase
    private let toggleTaskStatusUseCase: ToggleTaskStatusUseCase
    private let deleteTaskUseCase: DeleteTaskUseCase

    init(
        fetchTasksUseCase: FetchTasksUseCase,
        toggleTaskStatusUseCase: ToggleTaskStatusUseCase,
        deleteTaskUseCase: DeleteTaskUseCase
    ) {
        self.fetchTasksUseCase = fetchTasksUseCase
        self.toggleTaskStatusUseCase = toggleTaskStatusUseCase
        self.deleteTaskUseCase = deleteTaskUseCase
        super.init()
        bind()
    }

    var activeCount: Int { tasks.filter { !$0.isCompleted }.count }
    var completedCount: Int { tasks.filter(\.isCompleted).count }

    // MARK: - Actions

    func toggle(_ task: FocusTask) {
        do { try toggleTaskStatusUseCase.execute(task) }
        catch { handle(error) }
    }

    func delete(_ task: FocusTask) {
        do { try deleteTaskUseCase.execute(id: task.id) }
        catch { handle(error) }
    }

    func delete(at offsets: IndexSet) {
        offsets.map { filteredTasks[$0] }.forEach(delete)
    }

    // MARK: - Binding

    private func bind() {
        // 1) القائمة الأصلية من الـ Repository
        fetchTasksUseCase.publisher
            .sink { [weak self] tasks in self?.tasks = tasks }
            .store(in: &cancellables)

        // 2) القائمة المعروضة = الأصلية + الفلتر + البحث
        Publishers.CombineLatest3($tasks, $filter, $searchText)
            .map { tasks, filter, query in
                Self.apply(tasks: tasks, filter: filter, query: query)
            }
            .assign(to: &$filteredTasks)
    }

    nonisolated private static func apply(
        tasks: [FocusTask],
        filter: TaskFilter,
        query: String
    ) -> [FocusTask] {
        let query = query.trimmed
        return tasks
            .filter { task in
                filter.matches(task) &&
                (query.isEmpty ||
                 task.title.localizedCaseInsensitiveContains(query) ||
                 task.notes.localizedCaseInsensitiveContains(query))
            }
            .sorted { lhs, rhs in
                if lhs.isCompleted != rhs.isCompleted { return !lhs.isCompleted }
                if lhs.priority.sortWeight != rhs.priority.sortWeight {
                    return lhs.priority.sortWeight < rhs.priority.sortWeight
                }
                return lhs.createdAt > rhs.createdAt
            }
    }
}
