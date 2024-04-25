//
//  TaskRow.swift
//  TodoList
//
//  Created by jinwoong Kim on 4/25/24.
//

import SwiftUI
import SwiftData

struct TaskRow: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var task: Task
    var isFocused: FocusState<UUID?>.Binding
    
    var body: some View {
        HStack {
            Button {
                task.completed.toggle()
            } label: {
                Image(systemName: task.completed ? "circle.inset.filled" : "circle")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(task.completed ? .green : .gray)
            }
            Image(systemName: buildExclmationmark(with: task.priority))
                .foregroundStyle(.green)
            TextField("Emtpy", text: $task.body)
                .strikethrough(task.completed)
                .foregroundStyle(task.completed ? .gray : .primary)
                .focused(isFocused, equals: task.id)
        }
        .listSectionSeparator(.hidden)
        .swipeActions {
            Button(role: .destructive) {
                deleteTask(task)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
    
    private func deleteTask(_ task: Task) {
        modelContext.delete(task)
    }
    
    private func buildExclmationmark(with priority: Priority) -> String {
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

#Preview(traits: .sizeThatFitsLayout) {
    @FocusState var isFocused: UUID?
    return TaskRow(task: TaskStubs.task, isFocused: $isFocused)
}
