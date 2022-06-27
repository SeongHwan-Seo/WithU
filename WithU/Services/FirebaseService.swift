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

struct FirebaseService {
    static let db = Firestore.firestore()
    
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
    
//    static func setUser(_ user: User) -> AnyPublisher<Void, Error> {
//        Future<Void, Error> { promise in
//            print("setUser Start")
//            self.db
//        }
//
//
//    }
}
