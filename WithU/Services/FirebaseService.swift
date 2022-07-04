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
            let data = img.jpegData(compressionQuality: 0.5)
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
    
    
}
