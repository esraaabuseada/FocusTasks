//
//  ErrorView.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    var retry: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: AppSpacing.md) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 48))
                .foregroundStyle(AppColors.danger)
            Text(message)
                .font(AppFonts.body)
                .multilineTextAlignment(.center)
            if let retry {
                PrimaryButton(title: "Try again", systemImage: "arrow.clockwise", action: retry)
            }
        }
        .padding(AppSpacing.xl)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
