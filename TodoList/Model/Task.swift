//
//  Task.swift
//  TodoList
//
//  Created by jinwoong Kim on 4/25/24.
//

import Foundation
import SwiftData

@Model
final class Task {
    var id: UUID
    var completed: Bool
    var body: String
    var priority: Priority
    
    init(id: UUID = UUID(), completed: Bool, description: String, priority: Priority) {
        self.id = id
        self.completed = completed
        self.body = description
        self.priority = priority
    }
}

enum Priority: Int, Codable {
    case high = 2
    case medium = 1
    case low = 0
}
