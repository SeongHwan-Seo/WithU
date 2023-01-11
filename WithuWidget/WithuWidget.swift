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
        SimpleEntry(date: Date(), count: "")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let count = days(from: UserDefaults.shared.object(forKey: "fromDate") as! Date)
        let entry = SimpleEntry(date: Date(), count : "\(count)일")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let count = days(from: UserDefaults.shared.object(forKey: "fromDate") as! Date)
        let entry = SimpleEntry(date: Date(), count : "\(count)일")
        //10분마다 업데이트
        let nextRefresh = Calendar.current.date(byAdding: .minute, value: 10, to: currentDate)!
        let timeline = Timeline(entries: [entry], policy: .after(nextRefresh))
        completion(timeline)
    }
    
    private func days(from date: Date) -> Int {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let startDate = dateFormatter.date(from: date.toString()!)
        let endDate = dateFormatter.date(from: Date().toString()!)
        let interval = endDate?.timeIntervalSince(startDate!)
        let dayCount = Int(interval! / 86400)
        
        if UserDefaults.shared.bool(forKey: "check") {
            return dayCount + 1
        } else {
            return dayCount
        }
        
    }
    
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let count: String
    
}

struct WithuWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 225/255, green: 218/255, blue: 244/255), Color(red: 196/255, green: 203/255, blue: 242/255)]), startPoint: .top, endPoint: .bottom)
            
            VStack(spacing: 10) {
                Text("♥︎")
                    .font(.system(size: 16))
                    .foregroundColor(Color.white)
                Text("\(entry.count)")
                    .font(.system(size: 23, weight: .bold, design: .rounded))
                    .foregroundColor(Color.white)
            }
        }
        
        
        
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
        .supportedFamilies([.systemSmall])
    }
}

struct WithuWidget_Previews: PreviewProvider {
    static var previews: some View {
        WithuWidgetEntryView(entry: SimpleEntry(date: Date(), count: "1"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
