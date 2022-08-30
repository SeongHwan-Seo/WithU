//
//  Extension.swift
//  WithU
//
//  Created by seosh on 6/6/22.
//

import Foundation
import SwiftUI

extension Color {
    static let buttonBackground = Color("ButtonBackground")
    static let buttonForeground = Color("ButtonForeground")
    static let backgroundColor = Color("BackgroundColor")
    static let ForegroundColor = Color("ForegroundColor")
    static let popBackgroundColor = Color("PopBackgroundColor")
}

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}
