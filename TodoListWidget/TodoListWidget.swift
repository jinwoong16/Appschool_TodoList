//
//  TodoListWidget.swift
//  TodoListWidget
//
//  Created by jinwoong Kim on 4/25/24.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct TodoListWidgetEntryView : View {
    var entry: Provider.Entry
    @Query(sort: \Task.created) private var tasks: [Task]

    var body: some View {
        VStack {
            ForEach(tasks) { task in
                HStack {
                    Image(systemName: task.completed ? "circle.inset.filled" : "circle")
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(task.completed ? .green : .gray)
                    Text(task.body)
                        .strikethrough(task.completed)
                        .foregroundStyle(task.completed ? .gray : .primary)
                }
            }
        }
    }
}

struct TodoListWidget: Widget {
    let kind: String = "TodoListWidget"
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Task.self,
        ])

//        let storeURL = URL.documentsDirectory.appending(path: "taskdata.sqlite")
        let modelConfiguration = ModelConfiguration(schema: schema)
        
//        debugPrint("DB LOCATION: \(storeURL)")

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                TodoListWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
                    .modelContainer(sharedModelContainer)
            } else {
                TodoListWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    TodoListWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
