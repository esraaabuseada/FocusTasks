//
//  AppError.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Foundation

enum AppError: LocalizedError, Equatable, Sendable {
    case emptyTitle
    case titleTooLong(max: Int)
    case taskNotFound
    case storage(String)

    var errorDescription: String? {
        switch self {
        case .emptyTitle:
            return "Task title can't be empty."
        case .titleTooLong(let max):
            return "Task title can't be longer than \(max) characters."
        case .taskNotFound:
            return "This task no longer exists."
        case .storage(let message):
            return "Storage error: \(message)"
        }
    }
}

