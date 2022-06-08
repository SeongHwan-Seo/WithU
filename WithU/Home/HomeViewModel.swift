//
//  HomeViewModel.swift
//  WithU
//
//  Created by seosh on 6/7/22.
//

import SwiftUI
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    
    
    @Published var user: User = User(image: Image(systemName: "person"), nickName: UserDefaults.standard.string(forKey: "nickName") ?? "애칭",
                                     uimage: Image(systemName: "person"), unickName: UserDefaults.standard.string(forKey: "unickName") ?? "애칭")
    @Published var partner: Partner = Partner(image: Image(systemName: "person"), nickName: "애칭")
    @Published var dDay: Dday = Dday(message: "With U", count: "1일")
    
    
}


func setUserInfo(user: User) {
    
    if UserDefaults.standard.string(forKey: "id") == nil {
        UserDefaults.standard.set(user.id, forKey: "id")
    }
    
    if UserDefaults.standard.string(forKey: "nickName") == nil {
        UserDefaults.standard.set(user.nickName, forKey: "nickName")
    }
    
    if UserDefaults.standard.string(forKey: "unickName") == nil {
        UserDefaults.standard.set(user.unickName, forKey: "unickName")
    }
    
    let db = Firestore.firestore()
    db.collection("USERS").document(user.id ?? "").setData(["UUID" : user.id ?? "", "NICKNAME" : user.nickName, "UNICKNAME" : user.unickName ])
}
