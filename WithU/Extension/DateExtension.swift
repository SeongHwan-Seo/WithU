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
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: self)
    }
    
    func toStringHHmm() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"ko_KR")
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        return dateFormatter.string(from: self)
    }
}
