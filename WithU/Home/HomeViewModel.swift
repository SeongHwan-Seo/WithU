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
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var user: User = User()
    @Published var dDay: Dday = Dday(message: "With U", count: "1일")
    @Published var selectedImage: UIImage?
    @Published var isLoading: Bool = false
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    //앱 첫 사용자 등록
    func setInitUser() {
        let user = User()
        UserDefaults.standard.set(user.id, forKey: "id")// user.id 를 UserDeFaults에 저장
        
        FirebaseService.setUser(user)
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    self.loadUser()
                    return
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    //유저정보 업데이트
    func updateUser() {
        FirebaseService.setUser(user)
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    return
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    
    //사용자 정보 불러오기
    func loadUser() {
        FirebaseService.fetchUser()
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    print("finished : \(self.user.nickName)")
                    self.isLoading = true
                    return
                }
            } receiveValue: { [weak self] (user) in
                self?.user = user
                print("receiveValue : \(user.nickName)")
            }
            .store(in: &cancellables)
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




