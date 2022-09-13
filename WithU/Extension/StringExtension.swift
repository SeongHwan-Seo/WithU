//
//  StringExtension.swift
//  WithU
//
//  Created by SHSEO on 2022/09/13.
//

import Foundation


extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
            
    }
}
