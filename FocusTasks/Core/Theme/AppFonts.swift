//
//  AppFonts.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import SwiftUI

enum AppFonts {
    static let largeTitle = Font.system(.largeTitle, design: .rounded).weight(.bold)
    static let title      = Font.system(.title2, design: .rounded).weight(.semibold)
    static let headline   = Font.system(.headline, design: .rounded)
    static let body       = Font.system(.body, design: .rounded)
    static let caption    = Font.system(.caption, design: .rounded)
    static let statNumber = Font.system(size: 28, weight: .bold, design: .rounded)
}
