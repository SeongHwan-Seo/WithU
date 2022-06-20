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
    
//    init(from decoder: Decoder) throws {
//        let valuse = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.id = try valuse.decode(String.self, forKey: .id)
//        self.nickName = try valuse.decode(String.self, forKey: .nickName)
//        self.imageString = try valuse.decode(String.self, forKey: .imageString)
//        self.unickName = try valuse.decode(String.self, forKey: .unickName)
//        self.uimageString = try valuse.decode(String.self, forKey: .uimageString)
//        self.message = try valuse.decode(String.self, forKey: .message)
//        self.count = try valuse.decode(String.self, forKey: .count)
//    }
    
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
