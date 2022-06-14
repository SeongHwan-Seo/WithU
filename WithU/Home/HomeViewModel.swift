//
//  HomeViewModel.swift
//  WithU
//
//  Created by seosh on 6/7/22.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

class HomeViewModel: ObservableObject {
    @Published var user: User = User(image: Image(systemName: "greaterthan"), nickName: UserDefaults.standard.string(forKey: "nickName") ?? "애칭",
                                     uimage: Image(systemName: "lessthan"), unickName: UserDefaults.standard.string(forKey: "unickName") ?? "애칭"
                                     , message: UserDefaults.standard.string(forKey: "message") ?? "With U", count: UserDefaults.standard.string(forKey: "count") ?? "1일")
    @Published var dDay: Dday = Dday(message: "With U", count: "1일")
    @Published var selectedImage: UIImage?
    let db = Firestore.firestore()
    let storage = Storage.storage()
    func setUserInfo() {
        
        if UserDefaults.standard.string(forKey: "id") == nil {
            UserDefaults.standard.set(user.id, forKey: "id")
        }
        
        UserDefaults.standard.set(user.nickName, forKey: "nickName")
        UserDefaults.standard.set(user.unickName, forKey: "unickName")
        UserDefaults.standard.set(user.message, forKey: "message")
        UserDefaults.standard.set(user.count, forKey: "count")
        
        user.image = Image(uiImage: selectedImage!)
        
        
        // 유저정보 파이어스토어 저장
        db.collection("USERS").document(user.id ?? "").setData(["UUID" : user.id ?? "", "NICKNAME" : user.nickName, "UNICKNAME" : user.unickName ])
    }
    
    func uploadImage(img: UIImage, name: String) {
        let storageRef = storage.reference().child("images/\(name)")
        let data = img.jpegData(compressionQuality: 0.1)
        let metaData = StorageMetadata()
        metaData.contentType = "Image/jpg"
        
        //upload data
        if let data = data {
            storageRef.putData(data, metadata: metaData) { (metaData, err) in
                if let err = err {
                    print("err when uploading jpg\n\(err)")
                }
                
                if let metaData = metaData {
                    print("metaData: \(metaData)")
                }
            }
        }
    }
}

//func setUserInfo(user: User) {
//    
//    if UserDefaults.standard.string(forKey: "id") == nil {
//        UserDefaults.standard.set(user.id, forKey: "id")
//    }
//    
//    UserDefaults.standard.set(user.nickName, forKey: "nickName")
//    UserDefaults.standard.set(user.unickName, forKey: "unickName")
//    UserDefaults.standard.set(user.message, forKey: "message")
//    UserDefaults.standard.set(user.count, forKey: "count")
//    
//    
//    // 유저정보 파이어스토어 저장
//    let db = Firestore.firestore()
//    db.collection("USERS").document(user.id ?? "").setData(["UUID" : user.id ?? "", "NICKNAME" : user.nickName, "UNICKNAME" : user.unickName ])
//}


