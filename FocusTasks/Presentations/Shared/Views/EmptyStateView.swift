//
//  EmptyStateView.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import SwiftUI

struct EmptyStateView: View {
    let systemImage: String
    let title: String
    let message: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: AppSpacing.md) {
            Image(systemName: systemImage)
                .font(.system(size: 56))
                .foregroundStyle(AppColors.primary.opacity(0.7))
            Text(title)
                .font(AppFonts.title)
            Text(message)
                .font(AppFonts.body)
                .foregroundStyle(AppColors.textSecondary)
                .multilineTextAlignment(.center)

            if let actionTitle, let action {
                PrimaryButton(title: actionTitle, systemImage: "plus", action: action)
                    .padding(.top, AppSpacing.sm)
            }
        }
        .padding(AppSpacing.xl)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
