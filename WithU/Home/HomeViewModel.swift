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
    @Published var dayCount: Int = 1
    @Published var selectedImage: UIImage?
    @Published var uselectedImage: UIImage?
    @Published var bgSelectedImage: UIImage?
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
        
        FirebaseService.fetchUser()
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    if self.user.imageString == "" && self.user.uimageString == "" && self.user.bgImageString == "" {
                        self.isLoading = true
                    } else {
                        self.setImage()
                    }
                    
                    //self.isLoading = true
                    return
                }
            } receiveValue: { [weak self] (user) in
                self?.user = user

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
    
    //사귄날짜 ~ 오늘까지 일 수
    func days(from date: Date) -> Int {
        
        var dayCount = Calendar.current.dateComponents([.day], from: date, to: Date()).day
        
        if UserDefaults.standard.bool(forKey: "check") {
            return Int(dayCount ?? 0) + 1
        } else {
            return Int(dayCount ?? 0)
        }
        
        //return Int(dayCount ?? 0) + 1
    }
    
    func setImage() {
        var chk = true
        if self.user.imageString != "" {
            FirebaseService.fetchImage(imageName: user.imageString, id: user.id!)
                .sink{ (completion) in
                    switch completion {
                    case .failure(let error):
                        print(error)
                        return
                    case .finished:
                        if self.user.uimageString != "" {
                            chk = false
                        }
                        if chk { self.isLoading = true }
                        
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
                        if self.user.bgImageString != "" {
                            chk = false
                        }
                        if chk { self.isLoading = true }
                        
                        return
                    }
                } receiveValue: { [weak self] (image) in
                    self?.uselectedImage = image
                }
                .store(in: &cancellables)
        }
        
        if self.user.bgImageString != "" {
            FirebaseService.fetchImage(imageName: user.bgImageString, id: user.id!)
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
                    self?.bgSelectedImage = image
                }
                .store(in: &cancellables)
        }
        
        
    }
    
    
}




