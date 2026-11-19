//
//  FocusTasksApp.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 16/11/2026.
//

import SwiftUI

@main
struct FocusTasksApp: App {
    @StateObject private var container = AppContainer()
    @StateObject private var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(container)
                .environmentObject(coordinator)
        }
    }
}

struct RootView: View {
    @EnvironmentObject private var container: AppContainer
    @EnvironmentObject private var coordinator: AppCoordinator

    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            NavigationStack(path: $coordinator.homePath) {
                HomeView(viewModel: container.makeHomeViewModel())
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        case .details(let id):
                            TaskDetailsView(viewModel: container.makeTaskDetailsViewModel(taskID: id))
                        }
                    }
            }
            .tabItem { Label(AppTab.home.title, systemImage: AppTab.home.icon) }
            .tag(AppTab.home)

            NavigationStack {
                StatisticsView(viewModel: container.makeStatisticsViewModel())
            }
            .tabItem { Label(AppTab.statistics.title, systemImage: AppTab.statistics.icon) }
            .tag(AppTab.statistics)
        }
        .tint(AppColors.primary)
        .sheet(item: $coordinator.sheet) { sheet in
            switch sheet {
            case .add:
                AddEditTaskView(viewModel: container.makeAddEditTaskViewModel(mode: .add))
            case .edit(let task):
                AddEditTaskView(viewModel: container.makeAddEditTaskViewModel(mode: .edit(task)))
            }
        }
    }
}
