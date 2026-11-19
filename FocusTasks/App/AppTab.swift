//
//  AppTab.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Foundation

enum AppTab: String, CaseIterable, Identifiable {
    case home, statistics

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home:       return "Tasks"
        case .statistics: return "Statistics"
        }
    }

    var icon: String {
        switch self {
        case .home:       return "checklist"
        case .statistics: return "chart.pie"
        }
    }
}
