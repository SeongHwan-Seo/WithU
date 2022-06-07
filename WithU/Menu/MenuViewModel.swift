//
//  MenuViewModel.swift
//  WithU
//
//  Created by seosh on 4/13/22.
//

import Foundation

enum MenuViewModel: Int, CaseIterable {
    case anniversary
    case story
    case setting
    
    var title: String {
        switch self {
        case .anniversary: return "기념일"
        case .story: return "스토리"
        case .setting: return "설정"
        }
    }
    
    var imageName: String {
        switch self {
        case .anniversary: return "heart.text.square"
        case .story: return "person.2.crop.square.stack"
        case .setting: return "gearshape"
        }
    }
}


