//
//  CompletionCardView.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import SwiftUI

struct CompletionCardView: View {
    let rate: Double
    let completed: Int
    let total: Int

    var body: some View {
        VStack(spacing: AppSpacing.md) {
            ZStack {
                Circle()
                    .stroke(AppColors.primary.opacity(0.15), lineWidth: 14)
                Circle()
                    .trim(from: 0, to: rate)
                    .stroke(AppColors.primary, style: StrokeStyle(lineWidth: 14, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut(duration: 0.6), value: rate)
                Text(rate.formatted(.percent.precision(.fractionLength(0))))
                    .font(AppFonts.statNumber)
            }
            .frame(width: 140, height: 140)

            Text("\(completed) of \(total) tasks completed")
                .font(AppFonts.body)
                .foregroundStyle(AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(AppSpacing.lg)
        .cardStyle()
    }
}
