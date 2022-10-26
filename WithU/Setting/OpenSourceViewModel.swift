//
//  OpenSourceViewModel.swift
//  WithU
//
//  Created by SHSEO on 2022/10/26.
//

import Foundation

enum OpenSourceViewModel: Int, CaseIterable {
    case firebase
    case lottie
    case kingfisher
    
    
    var lib: String {
        switch self {
        case .firebase: return "firebase-ios-sdk"
        case .lottie: return "lottie-ios"
        case .kingfisher: return "Kingfisher"
        }
    }
    
    var url: String {
        switch self {
        case .firebase: return "https://github.com/firebase/firebase-ios-sdk"
        case .lottie: return "https://github.com/airbnb/lottie-ios"
        case .kingfisher: return "https://github.com/onevcat/Kingfisher"
        }
    }
}
