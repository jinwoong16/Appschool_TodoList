//
//  TodoListApp.swift
//  TodoList
//
//  Created by jinwoong Kim on 4/25/24.
//

import SwiftUI
import SwiftData

@main
struct TodoListApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            Task.self,
        ])

        let storeURL = URL.documentsDirectory.appending(path: "taskdata.sqlite")
        let modelConfiguration = ModelConfiguration(schema: schema, url: storeURL)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
