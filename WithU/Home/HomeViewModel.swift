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
    init() {
        fetchUser()
    }
    
    @Published var user: User = User(image: Image(systemName: "greaterthan"), nickName: UserDefaults.standard.string(forKey: "nickName") ?? "애칭",
                                     uimage: Image(systemName: "lessthan"), unickName: UserDefaults.standard.string(forKey: "unickName") ?? "애칭"
                                     , message: UserDefaults.standard.string(forKey: "message") ?? "With U", count: UserDefaults.standard.string(forKey: "count") ?? "")
    @Published var dDay: Dday = Dday(message: "With U", count: "1일")
    @Published var selectedImage: UIImage?
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    
    
    //유저정보 저장
    func setUserInfo() {
        
        if UserDefaults.standard.string(forKey: "id") == nil {
            UserDefaults.standard.set(user.id, forKey: "id")
        }
        
        UserDefaults.standard.set(user.nickName, forKey: "nickName")
        UserDefaults.standard.set(user.unickName, forKey: "unickName")
        UserDefaults.standard.set(user.message, forKey: "message")
        UserDefaults.standard.set(user.count, forKey: "count")
        
        if selectedImage != nil {
            user.image = Image(uiImage: selectedImage!)
        }
        
        
        //유저사진 firestorage에 저장
        let imgName = user.id! + "/" + UUID().uuidString
        uploadImage(img: selectedImage!, name: imgName)
        
        // 유저정보 파이어스토어 저장
        db.collection("USERS").document(user.id ?? "").setData(["UUID" : user.id ?? "", "NICKNAME" : user.nickName, "UNICKNAME" : user.unickName
                                                                , "IMAGE" : imgName])
    }
    
    //FireStorage image저장
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
    
    //유저정보 가져오기 from firebase
    func fetchUser() {
        db.collection("USERS").document(UserDefaults.standard.string(forKey: "id")!).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                print(data!)
                let unickName = data?["UNICKNAME"]
                let nickName = data?["NICKNAME"]
                let image = data?["IMAGE"]
                self.fetchImage(imageName: image! as! String)
                self.user.nickName = nickName! as! String
                self.user.unickName = unickName! as! String
            } else {
                print("Document does not exist")
                return
            }
        }
    }
    
    //FireStorage에서 이미지 가져오기
    func fetchImage(imageName: String) {
        let ref = storage.reference().child("images/" + "\(imageName)")
        
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("error while downloading image\n\(error.localizedDescription)")
                return
            } else {
                let image = UIImage(data: data!)
                self.user.image = Image(uiImage: image!)
            }
        }
    }
}




