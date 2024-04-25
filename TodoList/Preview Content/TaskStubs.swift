//
//  TaskStubs.swift
//  TodoList
//
//  Created by jinwoong Kim on 4/25/24.
//

import Foundation

struct TaskStubs {
    static var tasks = [
        Task(completed: false, description: "Wake up", priority: .low ),
        Task(completed: false, description: "Shower", priority: .medium),
        Task(completed: false, description: "Code", priority: .high),
        Task(completed: false, description: "Eat", priority: .high ),
        Task(completed: false, description: "Sleep", priority: .high),
        Task(completed: false, description: "Get groceries", priority: .high)
    ]
    static var task = tasks[0]
}
