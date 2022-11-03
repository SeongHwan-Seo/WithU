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
                        promise(.failure(err))
                    }
                    
                    if let metaData = metaData {
                        print("metaData: \(metaData)")
                        promise(.success(()))
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
                            promise(.failure(err))
                        }
                        
                        if let metaData = metaData {
                            print("metaData: \(metaData)")
                            if idx == img.count - 1 {
                                promise(.success(()))
                            }
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
            //            self.db.collection("users").document(userId)
            //                .updateData(["anniversaries" : FieldValue.arrayUnion([["id": anniversary.id,
            //                                                                      "title": anniversary.title,
            //                                                                      "date": anniversary.date]])
            //                ]) { error in
            //                    if let error = error {
            //                        promise(.failure(error))
            //                    } else {
            //                        promise(.success(()))
            //                    }
            //                }
            
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
                    "images": story.images,
                    "createDate": story.createDate,
                ]) {
                    error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        promise(.success(()))
                    }
                }
            
            //            self.db.collection("users").document(userId)
            //                .updateData([
            //                    "story" : ["id" : story.id
            //                               , "date" : story.date
            //                               , "content" : story.content
            //                               , "images": story.images
            //                               , "createDate": story.createDate,]
            //                ]) { error in
            //                    if let error = error {
            //                        promise(.failure(error))
            //                    } else {
            //                        promise(.success(()))
            //                    }
            //                }
            
        }
        .eraseToAnyPublisher()
    }
    
    
    /// 스토리삭제
    /// - Parameters:
    ///   - storyId: 스토리아이디
    ///   - userId: 유저아디디
    /// - Returns: void
    static func deleteStory(storyId: String, userId: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            self.db.collection("users").document(userId).collection("story")
                .document(storyId).delete() { error in
                    if let error = error {
                        print(#function)
                        print(error.localizedDescription)
                        promise(.failure(error))
                    }
                    else {
                        print(#function)
                        promise(.success(()))
                    }
                    
                }
        }
        .eraseToAnyPublisher()
    }
    
    
    /// 스토리 가져오기
    /// - Parameter userId: 유저 아이디
    /// - Returns: 스토리 배열
    static func fetchStories(_ userId: String) -> AnyPublisher<[Story], Error> {
        
        Future<[Story], Error> { promise in
            
            self.db.collection("users").document(userId).collection("story")
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
                    
                    var stories = [Story]()
                    snapshot.documents.forEach { document in
                        if let story = try? document.data(as: Story.self) {
                            if stories.contains(where: { $0.id == story.id}) { return }
                            
                            stories.append(story)
                        }
                        
                    }
                    
                    promise(.success(stories))
                }
        }
        .eraseToAnyPublisher()
    }
    
    
    /// 이미지 여러장 가져오기
    /// - Parameters:
    ///   - imageName: 이미지 이름 배열
    ///   - id: 유저 아이디
    /// - Returns: 이미지
    static func fetchImages(imageName: String, id: String, storyId: String) -> AnyPublisher<UIImage, Error> {
        Future<UIImage, Error> { promise in
            
            
            
            let ref = storage.reference().child("images/\(id)/story/\(storyId)/" + "\(imageName)")
            
            ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print("================================")
                    print("error while downloading image\n\(error.localizedDescription)")
                    print("================================")
                    promise(.failure(error))
                    
                    return
                } else {
                    promise(.success(UIImage(data: data!) ?? UIImage()))
                    
                    
                }
            }
            
            
            
            
            
        }
        .eraseToAnyPublisher()
    }
    
    
    /// 스토리 이미지 삭제
    /// - Parameters:
    ///   - storyId: 스토리 아이디
    ///   - userId: 유저 아이디
    /// - Returns: void
    static func deleteStoryImage(storyId: String, userId: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            let ref = storage.reference().child("images/\(userId)/story/\(storyId)")
            
            ref.listAll { values, error in
                if let error = error {
                    print("================================")
                    print("error while deleting image\n\(error.localizedDescription)")
                    print("================================")
                    promise(.failure(error))
                } else {
                    values.items.forEach{ item in
                        item.delete()
                    }
                    
                    promise(.success(()))
                }
            }
            
        }
        .eraseToAnyPublisher()
    }
    
    
    static func deleteAllInfo(userId: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            
            self.db.collection("users").document(userId).collection("story").getDocuments { snapshot, error in
                snapshot?.documents.forEach { document in
                    let docId = document.documentID
                    self.db.collection("users").document(userId).collection("story").document(docId).delete() { err in
                        if let error = err {
                            promise(.failure(error))
                        }
                    }
                }
            }
            
            self.db.collection("users").document(userId).collection("anniversary").getDocuments { snapshot, error in
                snapshot?.documents.forEach { document in
                    let docId = document.documentID
                    self.db.collection("users").document(userId).collection("anniversary").document(docId).delete() { err in
                        if let error = err {
                            promise(.failure(error))
                        }
                    }
                }
            }
            
            self.db.collection("users").document(userId).delete() { err in
                if let error = err {
                    promise(.failure(error))
                } else {
                }
                
            }
            
            var ref = storage.reference().child("images/\(userId)/")
            ref.listAll { values, err in
                if let error = err {
                    
                    promise(.failure(error))
                } else {
                    print(values)
                    values.items.forEach { item in
                        item.delete()
                    }
                    
                }
            }
            
            ref = storage.reference().child("images/\(userId)/story/")
            ref.listAll { values, err in
                if let error = err {
                    
                    promise(.failure(error))
                } else {
                    print(values)
                    values.prefixes.forEach { pre in
                        pre.listAll { values, err in
                            if let error = err {
                                print(error.localizedDescription)
                            } else {
                                values.items.forEach { item in
                                    item.delete()
                                }
                            }
                        }
                    }
                    
                    
                    promise(.success(()))
                }
            }
            
            
        }
        .eraseToAnyPublisher()
    }
    
    
}
