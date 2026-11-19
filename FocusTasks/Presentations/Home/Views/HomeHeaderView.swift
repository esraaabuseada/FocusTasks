//
//  HomeHeaderView.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import SwiftUI

struct HomeHeaderView: View {
    let activeCount: Int
    let completedCount: Int
    let totalCount: Int

    private var progress: Double {
        totalCount == 0 ? 0 : Double(completedCount) / Double(totalCount)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text(activeCount == 0 ? "All caught up 🎉" : "\(activeCount) task\(activeCount == 1 ? "" : "s") left")
                .font(AppFonts.title)
            Text("\(completedCount) of \(totalCount) completed")
                .font(AppFonts.caption)
                .foregroundStyle(AppColors.textSecondary)
            ProgressView(value: progress)
                .tint(AppColors.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(AppSpacing.md)
        .cardStyle()
    }
}
