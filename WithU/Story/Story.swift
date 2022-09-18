//
//  Story.swift
//  WithU
//
//  Created by SHSEO on 2022/09/13.
//

import SwiftUI
import Foundation

struct Story: Codable, Identifiable {
    var id: String
    var date: String
    var content: String
    var images: [String]
    var url: [URL]?
}
