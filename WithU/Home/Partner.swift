//
//  Partner.swift
//  WithU
//
//  Created by seosh on 5/30/22.
//

import SwiftUI

struct Partner: Identifiable {
    let id = UUID()
    
    let image: Image
    let nickName: String
    
    static let shared =
    Partner(image: Image(systemName: "person"),
         nickName: "파트너"
    )
}
