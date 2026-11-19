//
//  TaskDetailsView.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import SwiftUI

struct TaskDetailsView: View {
    @StateObject private var viewModel: TaskDetailsViewModel
    @EnvironmentObject private var coordinator: AppCoordinator
    @State private var showDeleteConfirmation = false

    init(viewModel: @autoclosure @escaping () -> TaskDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }

    var body: some View {
        Group {
            if let task = viewModel.task {
                details(for: task)
            } else {
                EmptyStateView(
                    systemImage: "questionmark.folder",
                    title: "Task not found",
                    message: "This task may have been deleted."
                )
            }
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if let task = viewModel.task {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button { coordinator.showEdit(task) } label: { Image(systemName: "pencil") }
                    Button(role: .destructive) { showDeleteConfirmation = true } label: { Image(systemName: "trash") }
                }
            }
        }
        .confirmationDialog("Delete this task?", isPresented: $showDeleteConfirmation, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                if viewModel.delete() { coordinator.pop() }
            }
        }
        .errorAlert(message: $viewModel.errorMessage)
    }

    private func details(for task: FocusTask) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.lg) {
                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    HStack {
                        Text(task.title)
                            .font(AppFonts.title)
                            .strikethrough(task.isCompleted)
                        Spacer()
                        PriorityBadge(priority: task.priority)
                    }
                    Label(
                        task.isCompleted ? "Completed" : "In progress",
                        systemImage: task.isCompleted ? "checkmark.circle.fill" : "clock"
                    )
                    .font(AppFonts.caption)
                    .foregroundStyle(task.isCompleted ? AppColors.success : AppColors.warning)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(AppSpacing.md)
                .cardStyle()

                if !task.notes.isEmpty {
                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        Text("Notes").font(AppFonts.headline)
                        Text(task.notes).font(AppFonts.body)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(AppSpacing.md)
                    .cardStyle()
                }

                VStack(spacing: AppSpacing.md) {
                    infoRow("Created", task.createdAt.shortDisplay, "plus.circle")
                    if let due = task.dueDate {
                        infoRow("Due", due.shortDisplay, "calendar")
                    }
                    if let done = task.completedAt {
                        infoRow("Completed", done.shortDisplay, "checkmark.seal")
                    }
                }
                .padding(AppSpacing.md)
                .cardStyle()

                PrimaryButton(
                    title: task.isCompleted ? "Mark as active" : "Mark as completed",
                    systemImage: task.isCompleted ? "arrow.uturn.backward" : "checkmark"
                ) {
                    viewModel.toggleStatus()
                }
            }
            .padding(AppSpacing.md)
        }
    }

    private func infoRow(_ title: String, _ value: String, _ systemImage: String) -> some View {
        HStack {
            Label(title, systemImage: systemImage)
                .foregroundStyle(AppColors.textSecondary)
            Spacer()
            Text(value)
        }
        .font(AppFonts.body)
    }
}
