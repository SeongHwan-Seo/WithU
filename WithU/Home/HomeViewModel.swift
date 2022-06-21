//
//  HomeViewModel.swift
//  WithU
//
//  Created by seosh on 6/7/22.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import Combine

class HomeViewModel: ObservableObject {
    init() {
        loadUser()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var user: User = User()
    @Published var dDay: Dday = Dday(message: "With U", count: "1일")
    @Published var selectedImage: UIImage?
    @Published var isLoading: Bool = false
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    func loadUser() {
        FirebaseService.fetchUser()
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    return
                }
            } receiveValue: { [weak self]user in
                self?.user = user
                self?.isLoading = true
            }
            .store(in: &cancellables)
    }
    
    
    //유저정보 저장
    func setUserInfo() {
        
        if UserDefaults.standard.string(forKey: "id") == nil {
            UserDefaults.standard.set(user.id, forKey: "id")
        }
        
        UserDefaults.standard.set(user.nickName, forKey: "nickName")
        UserDefaults.standard.set(user.unickName, forKey: "unickName")
        UserDefaults.standard.set(user.message, forKey: "message")
        UserDefaults.standard.set(user.count, forKey: "count")
        
        let imgName: String
        if selectedImage != nil {
            //user.image = Image(uiImage: selectedImage!)
            //유저사진 firestorage에 저장
            imgName = user.id! + "/" + UUID().uuidString
            uploadImage(img: selectedImage!, name: imgName)
        } else {
            imgName = ""
        }
        
        
        
        
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
    
  
    
    //FireStorage에서 이미지 가져오기
    func fetchImage(imageName: String) {
        let ref = storage.reference().child("images/" + "\(imageName)")
        
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("error while downloading image\n\(error.localizedDescription)")
                return
            } else {
                let image = UIImage(data: data!)
                //self.user.image = Image(uiImage: image!)
            }
        }
    }
}




