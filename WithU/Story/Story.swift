//
//  Story.swift
//  WithU
//
//  Created by SHSEO on 2022/09/13.
//

import SwiftUI
import Foundation

struct Story: Codable, Identifiable, Equatable {
    var id: String
    var date: String
    var content: String
    var images: [String]
    var url: [URL]?
    var createDate: String
    
    init(id: String, date: String, content: String, images: [String], url: [URL]? = nil, createDate: String) {
        self.id = id
        self.date = date
        self.content = content
        self.images = images
        self.url = url
        self.createDate = createDate
    }
    
    public static func ==(lhs: Story, rhs: Story) -> Bool{
        return lhs.id == rhs.id
        
    }
}

struct StoryModifyParam {
    var id: String
    var url: [URL]
}
