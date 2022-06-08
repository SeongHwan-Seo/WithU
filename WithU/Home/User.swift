//
//  User.swift
//  WithU
//
//  Created by seosh on 5/30/22.
//

import SwiftUI

struct User: Identifiable {
    
    let id = UserDefaults.standard.string(forKey: "id") != nil ? UserDefaults.standard.string(forKey: "id") : UUID().uuidString
    
    // My profile image and nickName
    var image: Image
    var nickName: String
    // Partner image and nickname
    var uimage: Image
    var unickName: String
    
    static let shared =
    User(image: Image(systemName: "person"),
         nickName: "나", uimage: Image(systemName: "person"), unickName: "파트너"
    )
}
