//
//  Anniversary.swift
//  WithU
//
//  Created by seosh on 7/20/22.
//

import Foundation

struct Anniversary: Codable, Identifiable {
    var id: String = UUID().uuidString
    var title: String = ""
    var date: Date
}
