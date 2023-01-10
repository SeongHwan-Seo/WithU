//
//  WithuWidget.swift
//  WithuWidget
//
//  Created by SHSEO on 2022/11/28.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), message: UserDefaults.shared.string(forKey: "message") ?? "")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), message: UserDefaults.shared.string(forKey: "message") ?? "")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, message: UserDefaults.shared.string(forKey: "message") ?? "")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let message: String
    
}

struct WithuWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
        Text(entry.message)
    }
}

@main
struct WithuWidget: Widget {
    let kind: String = "WithuWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WithuWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("커플 위젯")
        .description("우리의 소중한 추억을 위젯을 통해 확인하세요.")
    }
}

struct WithuWidget_Previews: PreviewProvider {
    static var previews: some View {
        WithuWidgetEntryView(entry: SimpleEntry(date: Date(), message: UserDefaults.shared.string(forKey: "message") ?? ""))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
