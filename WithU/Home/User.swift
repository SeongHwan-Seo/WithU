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
    var imageString: String
    var nickName: String
    // Partner image and nickname
    var uimage: Image
    var uimageString: String
    var unickName: String
    // User info message and D-day count
    var message: String
    var count: String
    
    
}
