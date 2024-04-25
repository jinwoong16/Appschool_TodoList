//
//  PreviewContainer.swift
//  TodoListTests
//
//  Created by jinwoong Kim on 4/25/24.
//

import Foundation
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: Task.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        TaskStubs.tasks.forEach { container.mainContext.insert($0) }
    
        return container
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}()
