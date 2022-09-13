//
//  DateExtension.swift
//  WithU
//
//  Created by SHSEO on 2022/09/13.
//

import Foundation

extension Date {
    func toString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
