//
//  AddEditTaskViewModel.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Foundation
import Combine

@MainActor
final class AddEditTaskViewModel: BaseViewModel {
    enum Mode {
        case add
        case edit(FocusTask)
    }

    @Published var title: String = ""
    @Published var notes: String = ""
    @Published var priority: TaskPriority = .medium
    @Published var hasDueDate: Bool = false
    @Published var dueDate: Date

    private let mode: Mode
    private let addTaskUseCase: AddTaskUseCase
    private let updateTaskUseCase: UpdateTaskUseCase

    init(
        mode: Mode,
        addTaskUseCase: AddTaskUseCase,
        updateTaskUseCase: UpdateTaskUseCase,
        dateProvider: any DateProviderProtocol
    ) {
        self.mode = mode
        self.addTaskUseCase = addTaskUseCase
        self.updateTaskUseCase = updateTaskUseCase
        self.dueDate = dateProvider.now
        super.init()

        if case .edit(let task) = mode {
            title = task.title
            notes = task.notes
            priority = task.priority
            if let due = task.dueDate {
                hasDueDate = true
                dueDate = due
            }
        }
    }

    var screenTitle: String {
        if case .edit = mode { return "Edit Task" }
        return "New Task"
    }

    var isValid: Bool {
        title.isValidTaskTitle && notes.count <= AppConstants.Validation.maxNotesLength
    }

    /// بيرجع true لو الحفظ نجح عشان الـ View تقفل الشاشة.
    func save() -> Bool {
        do {
            let due = hasDueDate ? dueDate : nil
            switch mode {
            case .add:
                try addTaskUseCase.execute(title: title, notes: notes, priority: priority, dueDate: due)
            case .edit(let original):
                var updated = original
                updated.title = title
                updated.notes = notes
                updated.priority = priority
                updated.dueDate = due
                try updateTaskUseCase.execute(updated)
            }
            return true
        } catch {
            handle(error)
            return false
        }
    }
}
