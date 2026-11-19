//
//  TaskListView.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import SwiftUI

struct TaskListView: View {
    let tasks: [FocusTask]
    let onToggle: (FocusTask) -> Void
    let onDelete: (FocusTask) -> Void
    let onSelect: (FocusTask) -> Void

    var body: some View {
        List {
            ForEach(tasks) { task in
                TaskRowView(
                    task: task,
                    onToggle: { onToggle(task) },
                    onSelect: { onSelect(task) }
                )
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: AppSpacing.xs, leading: 0, bottom: AppSpacing.xs, trailing: 0))
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) { onDelete(task) } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}
