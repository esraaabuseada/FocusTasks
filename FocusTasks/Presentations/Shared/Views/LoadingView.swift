//
//  LoadingView.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import SwiftUI

struct LoadingView: View {
    var message: String = "Loading..."

    var body: some View {
        VStack(spacing: AppSpacing.md) {
            ProgressView()
            Text(message)
                .font(AppFonts.caption)
                .foregroundStyle(AppColors.textSecondary)
        }
        .padding(AppSpacing.lg)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: AppSpacing.cornerRadius))
    }
}

