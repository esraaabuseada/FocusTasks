//
//  TaskStorageProtocol.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Foundation

@MainActor
protocol TaskStorageProtocol: AnyObject {
    func load() throws -> [TaskStorageDTO]
    func save(_ tasks: [TaskStorageDTO]) throws
}
