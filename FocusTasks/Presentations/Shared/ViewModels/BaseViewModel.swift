//
//  BaseViewModel.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Combine
import Foundation

@MainActor
class BaseViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?

    var cancellables = Set<AnyCancellable>()

    func handle(_ error: Error) {
        errorMessage = error.localizedDescription
    }

    func clearError() {
        errorMessage = nil
    }
}
