//
//  UserDefaultsTaskStorage.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Foundation

@MainActor
final class UserDefaultsTaskStorage: TaskStorageProtocol {
    private let defaults: UserDefaults
    private let key: String

    init(
        defaults: UserDefaults = .standard,
        key: String? = nil
    ) {
        self.defaults = defaults
        self.key = key ?? AppConstants.Storage.tasksKey
    }

    func load() throws -> [TaskStorageDTO] {
        guard let data = defaults.data(forKey: key) else { return [] }
        do {
            return try JSONDecoder().decode([TaskStorageDTO].self, from: data)
        } catch {
            throw AppError.storage(error.localizedDescription)
        }
    }

    func save(_ tasks: [TaskStorageDTO]) throws {
        do {
            let data = try JSONEncoder().encode(tasks)
            defaults.set(data, forKey: key)
        } catch {
            throw AppError.storage(error.localizedDescription)
        }
    }
}
