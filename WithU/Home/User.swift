//
//  User.swift
//  WithU
//
//  Created by seosh on 5/30/22.
//

import SwiftUI
import Foundation

struct User: Codable, Identifiable {
    
    var id = UserDefaults.standard.string(forKey: "id") != nil ? UserDefaults.standard.string(forKey: "id") : UUID().uuidString

    // My profile image and nickName
    var imageString: String = ""
    var nickName: String = "애칭"
    // Partner image and nickname
    var uimageString: String = ""
    var unickName: String = "애칭"
    // User info message and D-day count
    var message: String = "With U"
    var count: String = "1일"
    

    
}

enum CodingKeys: String, CodingKey {
    case id
    case nickName
    case imageString
    case unickName
    case uimageString
    case message
    case count
    
}
