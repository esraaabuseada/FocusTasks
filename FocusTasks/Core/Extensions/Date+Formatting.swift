//
//  Date+Formatting.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Foundation

extension Date {
    /// مثال: "Nov 16, 2026"
    var shortDisplay: String {
        formatted(date: .abbreviated, time: .omitted)
    }
}
