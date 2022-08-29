//
//  Anniversary.swift
//  WithU
//
//  Created by seosh on 7/20/22.
//

import Foundation
import SwiftUI


struct Anniversary: Codable, Identifiable {
    var id: String
    var title: String
    var date: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: AnniversaryKeys.self)
        
        self.id = try values.decode(String.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
        self.date = try values.decode(String.self, forKey: .date)
    }
    
    init(id: String, title: String, date: String) {
        self.id = id
        self.title = title
        self.date = date
    }
}

enum AnniversaryKeys: String, CodingKey {
    case id
    case title
    case date
}
