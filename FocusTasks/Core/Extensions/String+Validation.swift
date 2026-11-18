//
//  String+Validation.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Foundation

extension String {
    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isBlank: Bool {
        trimmed.isEmpty
    }

    /// بيرجع العنوان بعد التنضيف أو بيرمي Error لو غير صالح.
    func validatedTaskTitle() throws -> String {
        let clean = trimmed
        guard !clean.isEmpty else { throw AppError.emptyTitle }
        guard clean.count <= AppConstants.Validation.maxTitleLength else {
            throw AppError.titleTooLong(max: AppConstants.Validation.maxTitleLength)
        }
        return clean
    }

    var isValidTaskTitle: Bool {
        (try? validatedTaskTitle()) != nil
    }
}
