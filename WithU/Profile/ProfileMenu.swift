//
//  ProfileModel.swift
//  WithU
//
//  Created by seosh on 6/2/22.
//

import Foundation

enum ProfileMenu: String, CaseIterable, Identifiable {
    case me = "나"
    case partner = "파트너"
    
    var title: String { rawValue }
    var id: String { rawValue }
    
    var profileMenu: [String] {
        switch self {
        case.me: return Me.allCases.map { $0.title }
        case.partner: return Partner.allCases.map { $0.title }
        }
    }
    
    enum Me: String, CaseIterable, Identifiable {
        case myChangeNickname = "애칭 변경"
        case myChangeImage = "사진 변경"
        
        var title: String { rawValue }
        var id: String { rawValue }
    }
    
    enum Partner: String, CaseIterable, Identifiable {
        case partnerChangeNickname = "애칭 변경"
        case partnerChangeImage = "사진 변경"
        
        var title: String { rawValue }
        var id: String { rawValue }
    }
}
