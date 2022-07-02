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
    @Published var uselectedImage: UIImage?
    @Published var isLoading: Bool = false
    let db = Firestore.firestore()
    //let storage = Storage.storage()
    
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
        var chk = true
        
        FirebaseService.fetchUser()
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    print("finished : \(self.user.nickName)")
                    print("finished")
                    print(self.selectedImage)
                    if self.user.imageString == "" && self.user.uimageString == "" {
                        self.isLoading = true
                    } else {
                        self.setImage()
                    }
                    
                    //self.isLoading = true
                    return
                }
            } receiveValue: { [weak self] (user) in
                self?.user = user
                print("receiveValue")
                print(self?.selectedImage)
//                if self?.user.imageString != "" {
//                    chk = false
//
//                    if self?.selectedImage != nil {
//                        chk = true
//                    }
//                }
//
//                if self?.user.uimageString != "" {
//                    chk = false
//
//                    if self?.uselectedImage != nil {
//                        chk = true
//                    }
//                }
            }
            .store(in: &cancellables)
    }
    
    //FireStore 프로필 사진 저장
    func uploadImage(img: UIImage, name: String) {
        FirebaseService.uploadImage(img: img, name: name, dic: user.id!)
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
    
    func setImage() {
        if self.user.imageString != "" {
            FirebaseService.fetchImage(imageName: user.imageString, id: user.id!)
                .sink{ (completion) in
                    switch completion {
                    case .failure(let error):
                        print(error)
                        return
                    case .finished:
                        self.isLoading = true
                        return
                    }
                } receiveValue: { [weak self] (image) in
                    self?.selectedImage = image
                }
                .store(in: &cancellables)
        }
        
        if self.user.uimageString != "" {
            FirebaseService.fetchImage(imageName: user.uimageString, id: user.id!)
                .sink{ (completion) in
                    switch completion {
                    case .failure(let error):
                        print(error)
                        return
                    case .finished:
                        self.isLoading = true
                        return
                    }
                } receiveValue: { [weak self] (image) in
                    self?.uselectedImage = image
                }
                .store(in: &cancellables)
        }
    }
    
    func setImage2() {
        if self.user.imageString != "" {
            let image = FirebaseService.fetchImage2(imageName: user.imageString, id: user.id!)
            print(image)
            selectedImage = image
        }
        if self.user.uimageString != "" {
            let image = FirebaseService.fetchImage2(imageName: user.uimageString, id: user.id!)
            uselectedImage = image
        }
        
        self.isLoading = true
    }
    
    
    
    
    
}




