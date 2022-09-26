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
    
    init(id: String, date: String, content: String, images: [String], url: [URL]? = nil) {
        self.id = id
        self.date = date
        self.content = content
        self.images = images
        self.url = url
    }
    
    public static func ==(lhs: Story, rhs: Story) -> Bool{
        return lhs.id == rhs.id
        
    }
}
