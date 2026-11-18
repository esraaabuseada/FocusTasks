//
//  TaskRepositoryProtocol.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import Combine
import Foundation

@MainActor
protocol TaskRepositoryProtocol: AnyObject { ///////
    /// بيبعت القائمة الحالية فوراً وبعدها كل ما تتغير.
    var tasksPublisher: AnyPublisher<[FocusTask], Never> { get }

    func fetchTasks() throws -> [FocusTask]
    func add(_ task: FocusTask) throws
    func update(_ task: FocusTask) throws
    func delete(id: UUID) throws
}
