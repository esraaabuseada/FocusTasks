//
//  TaskPriority.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Foundation

enum TaskPriority: String, CaseIterable, Codable, Identifiable, Sendable {
    case low, medium, high

    var id: String { rawValue }

    var title: String {
        switch self {
        case .low:    return "Low"
        case .medium: return "Medium"
        case .high:   return "High"
        }
    }

    /// رقم أقل = أولوية أعلى في الترتيب.
    var sortWeight: Int {
        switch self {
        case .high:   return 0
        case .medium: return 1
        case .low:    return 2
        }
    }
}
