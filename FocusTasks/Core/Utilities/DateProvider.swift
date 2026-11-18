//
//  DateProvider.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Foundation

/// بنعمل abstraction للوقت عشان نقدر نتحكم فيه في الـ Tests.
protocol DateProviderProtocol: Sendable {
    var now: Date { get }
}

struct SystemDateProvider: DateProviderProtocol {
    var now: Date { Date() }
}
