//
//  AppColors.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import SwiftUI

enum AppColors {
    static let primary = Color(hex: "#5B5BD6")
    static let success = Color(hex: "#2FB67C")
    static let warning = Color(hex: "#F5A623")
    static let danger  = Color(hex: "#E5484D")

    static let background    = Color(.systemGroupedBackground)
    static let card          = Color(.secondarySystemGroupedBackground)
    static let textPrimary   = Color.primary
    static let textSecondary = Color.secondary

    static func priorityColor(_ priority: TaskPriority) -> Color {
        switch priority {
        case .low:    return success
        case .medium: return warning
        case .high:   return danger
        }
    }
}
