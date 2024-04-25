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
                TaskRow(task: task, isFocused: $isFocused)
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
}

#Preview {
    Home()
        .modelContainer(previewContainer)
}
