//
//  TaskFilter.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Foundation

enum TaskFilter: String, CaseIterable, Identifiable, Sendable {
    case all, active, completed

    var id: String { rawValue }

    var title: String {
        switch self {
        case .all:       return "All"
        case .active:    return "Active"
        case .completed: return "Done"
        }
    }

    func matches(_ task: FocusTask) -> Bool {
        switch self {
        case .all:       return true
        case .active:    return !task.isCompleted
        case .completed: return task.isCompleted
        }
    }
}
