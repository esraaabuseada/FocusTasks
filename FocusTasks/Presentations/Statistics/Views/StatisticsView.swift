//
//  StatisticsView.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import SwiftUI

struct StatisticsView: View {
    @StateObject private var viewModel: StatisticsViewModel

    init(viewModel: @autoclosure @escaping () -> StatisticsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.lg) {
                CompletionCardView(
                    rate: viewModel.snapshot.completionRate,
                    completed: viewModel.snapshot.completed,
                    total: viewModel.snapshot.total
                )
                StatisticsSummaryView(snapshot: viewModel.snapshot)
            }
            .padding(AppSpacing.md)
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("Statistics")
    }
}
