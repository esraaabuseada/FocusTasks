//
//  AppContainer.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Foundation
import Combine

/// Composition Root: المكان الوحيد اللي بنركّب فيه كل الـ dependencies.
@MainActor
final class AppContainer: ObservableObject {
   
    private let dateProvider: any DateProviderProtocol
       private let repository: any TaskRepositoryProtocol

       private let fetchTasks: FetchTasksUseCase
       private let addTask: AddTaskUseCase
       private let updateTask: UpdateTaskUseCase
       private let deleteTask: DeleteTaskUseCase
       private let toggleTask: ToggleTaskStatusUseCase

       init(
           storage: (any TaskStorageProtocol)? = nil,
           dateProvider: (any DateProviderProtocol)? = nil
       ) {
           let storage = storage ?? UserDefaultsTaskStorage()
           let dateProvider = dateProvider ?? SystemDateProvider()

           let repository = LocalTaskRepository(storage: storage)
           self.repository = repository
           self.dateProvider = dateProvider

           fetchTasks = FetchTasksUseCase(repository: repository)
           addTask    = AddTaskUseCase(repository: repository, dateProvider: dateProvider)
           updateTask = UpdateTaskUseCase(repository: repository)
           deleteTask = DeleteTaskUseCase(repository: repository)
           toggleTask = ToggleTaskStatusUseCase(repository: repository, dateProvider: dateProvider)
       }
    

    // MARK: - ViewModel factories

    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            fetchTasksUseCase: fetchTasks,
            toggleTaskStatusUseCase: toggleTask,
            deleteTaskUseCase: deleteTask
        )
    }

    func makeAddEditTaskViewModel(mode: AddEditTaskViewModel.Mode) -> AddEditTaskViewModel {
        AddEditTaskViewModel(
            mode: mode,
            addTaskUseCase: addTask,
            updateTaskUseCase: updateTask,
            dateProvider: dateProvider
        )
    }

    func makeTaskDetailsViewModel(taskID: UUID) -> TaskDetailsViewModel {
        TaskDetailsViewModel(
            taskID: taskID,
            fetchTasksUseCase: fetchTasks,
            toggleTaskStatusUseCase: toggleTask,
            deleteTaskUseCase: deleteTask
        )
    }

    func makeStatisticsViewModel() -> StatisticsViewModel {
        StatisticsViewModel(fetchTasksUseCase: fetchTasks, dateProvider: dateProvider)
    }
}
