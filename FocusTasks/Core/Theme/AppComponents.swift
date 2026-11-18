//
//  AppComponents.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import SwiftUI

// MARK: - Card

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(AppColors.card)
            .clipShape(RoundedRectangle(cornerRadius: AppSpacing.cornerRadius, style: .continuous))
    }
}

// MARK: - Priority Badge

struct PriorityBadge: View {
    let priority: TaskPriority

    var body: some View {
        let color = AppColors.priorityColor(priority)
        Text(priority.title)
            .font(AppFonts.caption.bold())
            .padding(.horizontal, AppSpacing.sm)////
            .padding(.vertical, AppSpacing.xs) ////
            .foregroundStyle(color)
            .background(color.opacity(0.15))
            .clipShape(Capsule()) //////
    }
}

// MARK: - View helpers

extension View {
    func cardStyle() -> some View {
        modifier(CardModifier())
    }

    /// Alert جاهز لعرض أي رسالة خطأ من الـ ViewModel.
    func errorAlert(message: Binding<String?>) -> some View { ////////
        alert(
            "Something went wrong",
            isPresented: Binding(
                get: { message.wrappedValue != nil },
                set: { if !$0 { message.wrappedValue = nil } }
            )
        ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(message.wrappedValue ?? "")
        }
    }
}
