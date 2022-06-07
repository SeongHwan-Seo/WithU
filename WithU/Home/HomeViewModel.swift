//
//  HomeViewModel.swift
//  WithU
//
//  Created by seosh on 6/7/22.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var user: User = User(image: Image(systemName: "person"), nickName: "애칭")
    @Published var partner: Partner = Partner(image: Image(systemName: "person"), nickName: "애칭")
    @Published var dDay: Dday = Dday(message: "With U", count: "1일")
}
