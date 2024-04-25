//
//  Home.swift
//  TodoList
//
//  Created by jinwoong Kim on 4/25/24.
//

import SwiftUI

struct Home: View {
    let tasks: [Task]
    
    var body: some View {
        List(tasks) { task in
            HStack {
                Button {
                    task.completed.toggle()
                } label: {
                    Image(systemName: task.completed ? "checkmark.square" : "square")
                }
                Text(task.body)
                Spacer()
                Image(systemName: buildExclmationmark(with: task.priority))
            }
        }
    }
    
    
    func buildExclmationmark(with priority: Priority) -> String {
        switch priority {
            case .high:
                return "exclamationmark"
            case .medium:
                return "exclamationmark.2"
            case .low:
                return "exclamationmark.3"
        }
    }
}

#Preview {
    Home(tasks: TaskStubs.tasks)
}
