//
//   HomeView.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    @EnvironmentObject private var coordinator: AppCoordinator

    /// @autoclosure عشان الـ ViewModel يتعمل مرة واحدة بس مش مع كل re-render.
    init(viewModel: @autoclosure @escaping () -> HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }

    var body: some View {
        VStack(spacing: AppSpacing.md) {
            HomeHeaderView(
                activeCount: viewModel.activeCount,
                completedCount: viewModel.completedCount,
                totalCount: viewModel.tasks.count
            )
            TaskFilterView(selection: $viewModel.filter)
            content
        }
        .padding(.horizontal, AppSpacing.md)
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("FocusTasks")
        .searchable(text: $viewModel.searchText, prompt: "Search tasks")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button { coordinator.showAdd() } label: { Image(systemName: "plus") }
            }
        }
        .overlay { if viewModel.isLoading { LoadingView() } }
        .errorAlert(message: $viewModel.errorMessage)
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.tasks.isEmpty {
            EmptyStateView(
                systemImage: "checklist",
                title: "No tasks yet",
                message: "Add your first task and start focusing.",
                actionTitle: "Add task",
                action: { coordinator.showAdd() }
            )
        } else if viewModel.filteredTasks.isEmpty {
            EmptyStateView(
                systemImage: "magnifyingglass",
                title: "Nothing found",
                message: "Try a different filter or search."
            )
        } else {
            TaskListView(
                tasks: viewModel.filteredTasks,
                onToggle: viewModel.toggle,
                onDelete: viewModel.delete,
                onSelect: { coordinator.showDetails(id: $0.id) }
            )
        }
    }
}
