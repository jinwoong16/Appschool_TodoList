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
                    Spacer()
                    Image(systemName: buildExclmationmark(with: task.priority))
                }
                .listSectionSeparator(.hidden)
                .swipeActions {
                    Button(role: .destructive) {
                        delete(task: task)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("To Do")
        }
    }
    
    private func delete(task: Task) {
        
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
