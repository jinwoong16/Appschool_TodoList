//
//  Home.swift
//  TodoList
//
//  Created by jinwoong Kim on 4/25/24.
//

import SwiftUI
import SwiftData

struct Home: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Task.created) private var tasks: [Task]
    
    @FocusState private var isFocused: UUID?
    @State private var isEditing: Bool = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemGreen]
    }
    
    var body: some View {
        NavigationStack {
            List(tasks) { task in
                @Bindable var task = task
                HStack {
                    Button {
                        task.completed.toggle()
                    } label: {
                        Image(systemName: task.completed ? "checkmark.square" : "square")
                    }
                    TextField("Emtpy", text: $task.body)
                        .focused($isFocused, equals: task.id)
                    Spacer()
                    Image(systemName: buildExclmationmark(with: task.priority))
                }
                .listSectionSeparator(.hidden)
                .swipeActions {
                    Button(role: .destructive) {
                        // TODO: Delete item from database
                        deleteTask(task)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("To Do")
            .toolbar {
                if isEditing {
                    ToolbarItemGroup {
                        Button {
                            isEditing = false
                            isFocused = nil
                        } label: {
                            Text("Done")
                        }
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        addTask()
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .symbolRenderingMode(.multicolor)
                            Text("Add new todo")
                                .foregroundStyle(.green)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
    
    private func addTask() {
        let emptyTask = Task(completed: false, description: "", priority: .low)
        modelContext.insert(emptyTask)
        isEditing = true
        isFocused = emptyTask.id
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

#Preview {
    Home()
        .modelContainer(previewContainer)
}
