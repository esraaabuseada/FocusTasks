//
//   TaskRowView.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import SwiftUI

struct TaskRowView: View {
    let task: FocusTask
    let onToggle: () -> Void
    let onSelect: () -> Void

    var body: some View {
        HStack(spacing: AppSpacing.md) {
            Button(action: onToggle) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(task.isCompleted ? AppColors.success : AppColors.priorityColor(task.priority))
            }
            .buttonStyle(.borderless)

            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text(task.title)
                    .font(AppFonts.headline)
                    .strikethrough(task.isCompleted)
                    .foregroundStyle(task.isCompleted ? AppColors.textSecondary : AppColors.textPrimary)

                if let due = task.dueDate {
                    Label(due.shortDisplay, systemImage: "calendar")
                        .font(AppFonts.caption)
                        .foregroundStyle(task.isOverdue(now: .now) ? AppColors.danger : AppColors.textSecondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .onTapGesture(perform: onSelect)

            PriorityBadge(priority: task.priority)
        }
        .padding(AppSpacing.md)
        .cardStyle()
    }
}
