//
//  StatisticsSummaryView.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import SwiftUI

struct StatisticsSummaryView: View {
    let snapshot: StatisticsSnapshot

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            LazyVGrid(columns: columns, spacing: AppSpacing.md) {
                StatTile(title: "Total", value: snapshot.total, systemImage: "tray.full", color: AppColors.primary)
                StatTile(title: "Completed", value: snapshot.completed, systemImage: "checkmark.circle", color: AppColors.success)
                StatTile(title: "Pending", value: snapshot.pending, systemImage: "clock", color: AppColors.warning)
                StatTile(title: "Overdue", value: snapshot.overdue, systemImage: "exclamationmark.triangle", color: AppColors.danger)
            }

            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("By priority").font(AppFonts.headline)
                ForEach(TaskPriority.allCases) { priority in
                    HStack {
                        PriorityBadge(priority: priority)
                        Spacer()
                        Text("\(snapshot.byPriority[priority, default: 0])")
                            .font(AppFonts.headline)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(AppSpacing.md)
            .cardStyle()
        }
    }
}

private struct StatTile: View {
    let title: String
    let value: Int
    let systemImage: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Image(systemName: systemImage)
                .foregroundStyle(color)
            Text("\(value)")
                .font(AppFonts.statNumber)
            Text(title)
                .font(AppFonts.caption)
                .foregroundStyle(AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(AppSpacing.md)
        .cardStyle()
    }
}
