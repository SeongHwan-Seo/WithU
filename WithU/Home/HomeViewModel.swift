//
//  HomeViewModel.swift
//  WithU
//
//  Created by seosh on 6/7/22.
//

import SwiftUI
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    @Published var user: User = User(image: Image(systemName: "greaterthan"), nickName: UserDefaults.standard.string(forKey: "nickName") ?? "애칭",
                                     uimage: Image(systemName: "lessthan"), unickName: UserDefaults.standard.string(forKey: "unickName") ?? "애칭"
                                     , message: UserDefaults.standard.string(forKey: "message") ?? "With U", count: UserDefaults.standard.string(forKey: "count") ?? "1일")
    @Published var dDay: Dday = Dday(message: "With U", count: "1일")
    
    
}


func setUserInfo(user: User) {
    
    if UserDefaults.standard.string(forKey: "id") == nil {
        UserDefaults.standard.set(user.id, forKey: "id")
    }
    
    UserDefaults.standard.set(user.nickName, forKey: "nickName")
    UserDefaults.standard.set(user.unickName, forKey: "unickName")
    UserDefaults.standard.set(user.message, forKey: "message")
    UserDefaults.standard.set(user.count, forKey: "count")
    
    
    // 유저정보 파이어스토어 저장
    let db = Firestore.firestore()
    db.collection("USERS").document(user.id ?? "").setData(["UUID" : user.id ?? "", "NICKNAME" : user.nickName, "UNICKNAME" : user.unickName ])
}
