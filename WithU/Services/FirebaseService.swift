//
//  FirebaseService.swift
//  WithU
//
//  Created by seosh on 6/20/22.
//

import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

struct FirebaseService {
    static let db = Firestore.firestore()
    static let storage = Storage.storage()
    
    static func fetchUser() -> AnyPublisher<User, Error> {
        Future<User, Error> { promise in
            self.db.collection("users").document(UserDefaults.standard.string(forKey: "id")!)
                .getDocument { (snapshot, error) in
                    if let error = error {
                        print("fetUser() Error : error")
                        promise(.failure(error))
                        return
                    }
                    guard let snapshot = snapshot else {
                        print("fetUser() Error : snapshot error")
                        promise(.failure(FirebaseError.badSnapshot))
                        return
                    }
                    
                    var user = User()
                    if let data = try? snapshot.data(as: User.self) {
                        user = data
                        
                    }
                    
                    promise(.success(user))
                }
        }
        .eraseToAnyPublisher()
    }
    
    static func setUser(_ user: User) -> AnyPublisher<Void, Error> {
        Future<Void,  Error> { promise in
            print("setUser : start")
            try? self.db.collection("users").document(user.id!).setData(from: user) { error in
                if let error = error {
                    print("setUser : failure")
                    promise(.failure(error))
                } else {
                    print("setUser : success")
                    
                    promise(.success(()))
                }
            }
            
        }
        .eraseToAnyPublisher()
    }
    
    //FireStorage image저장
    static func uploadImage(img: UIImage, name: String, dic: String) -> AnyPublisher<Void, Error>{
        Future<Void, Error> { promise in
            let storageRef = storage.reference().child("images/\(dic)/\(name)")
            let data = img.jpegData(compressionQuality: 0.1)
            let metaData = StorageMetadata()
            metaData.contentType = "Image/png"
            
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
        .eraseToAnyPublisher()
    }
    
    
    /// 파이어베이스 이미지 배열 저장
    /// - Parameters:
    ///   - img: 이미지 배열
    ///   - name: 유저아이디
    ///   - dic: 폴더이름(유저아이디)
    /// - Returns: <#description#>
    static func uploadImage(img: [UIImage],imgName: [String], dic: String, storyId: String) -> AnyPublisher<Void, Error>{
        Future<Void, Error> { promise in
            print(imgName)
            let metaData = StorageMetadata()
            metaData.contentType = "Image/png"
            for idx in 0..<img.count{
                let storageRef = storage.reference().child("images/\(dic)/story/\(storyId)/\(imgName[idx])")
                let data = img[idx].jpegData(compressionQuality: 0.1)
                
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
        .eraseToAnyPublisher()
    }
    
    //FireStorage에서 이미지 가져오기
    static func fetchImage(imageName: String, id: String) -> AnyPublisher<UIImage, Error> {
        Future<UIImage, Error> { promise in
            let ref = storage.reference().child("images/\(id)/" + "\(imageName)")
            
            ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print("error while downloading image\n\(error.localizedDescription)")
                    promise(.failure(error))
                    return
                } else {
                    promise(.success(UIImage(data: data!) ?? UIImage()))
                    
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    //기념일 생성
    static func createAnniversary(_ anniversary: Anniversary, _ userId: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            
            self.db.collection("users").document(userId).collection("anniversary")
                .document(anniversary.id).setData([
                    "id": anniversary.id,
                    "title": anniversary.title,
                    "date": anniversary.date
                ]) {
                    error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        promise(.success(()))
                    }
                }
            
        }
        .eraseToAnyPublisher()
    }
    
    //기념일 가져오기
    static func fetchAnniversaries(_ userId: String) -> AnyPublisher<[Anniversary], Error> {
        
        Future<[Anniversary], Error> { promise in
            self.db.collection("users").document(userId).collection("anniversary")
                .getDocuments{ (snapshot, error) in
                    if let error = error {
                        promise(.failure(error))
                        return
                    }
                    
                    guard let snapshot = snapshot else {
                        print("fetAnniversary() Error : snapshot error")
                        promise(.failure(FirebaseError.badSnapshot))
                        return
                    }
                    
                    var anniversaries = [Anniversary]()
                    snapshot.documents.forEach { document in
                        if let anniversary = try? document.data(as: Anniversary.self) {
                            if anniversaries.contains(where: { $0.id == anniversary.id}) { return }
                            anniversaries.append(anniversary)
                            
                            
                        }
                    }
                    
                    promise(.success(anniversaries))
                }
        }
        .eraseToAnyPublisher()
    }
    
    
    static func deleteAnniversary(_ anniversaryId: String, _ userId: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            self.db.collection("users").document(userId).collection("anniversary")
                .document(anniversaryId).delete() { error in
                    if let error = error {
                        print(#function)
                        print(error.localizedDescription)
                    }
                    else {
                        print(#function)
                        
                    }
                    
                }
        }
        .eraseToAnyPublisher()
    }
    
    static func createStory(story: Story, userId: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            
            self.db.collection("users").document(userId).collection("story")
                .document(story.id).setData([
                    "id": story.id,
                    "date": story.date,
                    "content": story.content,
                    "images": story.images
                ]) {
                    error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        promise(.success(()))
                    }
                }
            
        }
        .eraseToAnyPublisher()
    }
}
