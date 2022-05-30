//
//  User.swift
//  WithU
//
//  Created by seosh on 5/30/22.
//

import SwiftUI

struct User: Identifiable {
    let id = UUID()
    
    let image: Image
    let nickName: String
    
    static let shared =
    User(image: Image(systemName: "person"),
         nickName: "나"
    )
}
