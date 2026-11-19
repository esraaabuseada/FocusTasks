//
//  TaskDetailsViewModel.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Combine
import Foundation

@MainActor
final class TaskDetailsViewModel: BaseViewModel {
    @Published private(set) var task: FocusTask?

    private let taskID: UUID
    private let fetchTasksUseCase: FetchTasksUseCase
    private let toggleTaskStatusUseCase: ToggleTaskStatusUseCase
    private let deleteTaskUseCase: DeleteTaskUseCase

    init(
        taskID: UUID,
        fetchTasksUseCase: FetchTasksUseCase,
        toggleTaskStatusUseCase: ToggleTaskStatusUseCase,
        deleteTaskUseCase: DeleteTaskUseCase
    ) {
        self.taskID = taskID
        self.fetchTasksUseCase = fetchTasksUseCase
        self.toggleTaskStatusUseCase = toggleTaskStatusUseCase
        self.deleteTaskUseCase = deleteTaskUseCase
        super.init()

        // بنتابع المهمة دي بالذات: لو اتعدلت من أي مكان الشاشة بتتحدث لوحدها.
        fetchTasksUseCase.publisher
            .map { tasks in tasks.first { $0.id == taskID } }
            .assign(to: &$task)
    }

    func toggleStatus() {
        guard let task else { return }
        do { try toggleTaskStatusUseCase.execute(task) }
        catch { handle(error) }
    }

    func delete() -> Bool {
        do {
            try deleteTaskUseCase.execute(id: taskID)
            return true
        } catch {
            handle(error)
            return false
        }
    }
}
