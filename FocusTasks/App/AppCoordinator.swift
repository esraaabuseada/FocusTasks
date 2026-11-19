//
//  AppCoordinator.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Foundation
import Combine

enum AppRoute: Hashable {
    case details(UUID)
}

enum AppSheet: Identifiable {
    case add
    case edit(FocusTask)

    var id: String {
        switch self {
        case .add:            return "add"
        case .edit(let task): return "edit-\(task.id)"
        }
    }
}

@MainActor
final class AppCoordinator: ObservableObject {
    
    
    @Published var selectedTab: AppTab = .home
    @Published var homePath: [AppRoute] = []
    @Published var sheet: AppSheet?

    func showDetails(id: UUID) { homePath.append(.details(id)) }
    func showAdd()             { sheet = .add }
    func showEdit(_ task: FocusTask) { sheet = .edit(task) }
    func dismissSheet()        { sheet = nil }
    func pop()                 { _ = homePath.popLast() }
    func popToRoot()           { homePath.removeAll() }
}
