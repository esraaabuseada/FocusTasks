//
//  PrimaryButton.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var systemImage: String? = nil
    var isEnabled: Bool = true
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: AppSpacing.sm) {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title).font(AppFonts.headline)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.md)
            .foregroundStyle(.white)
            .background(isEnabled ? AppColors.primary : Color.gray.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: AppSpacing.cornerRadius, style: .continuous))
        }
        .disabled(!isEnabled)
    }
}
