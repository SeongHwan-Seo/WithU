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
                        promise(.failure(error))
                        return
                    }
                    guard let snapshot = snapshot else {
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
    
    static func setInitUser() -> AnyPublisher<User, Error> {
        Future<User,  Error> { promise in
            var user = User()
            //self.db.collection("users").document(user.id!).setData(from: user)
        }
        .eraseToAnyPublisher()
    }
    
//    static func setUser() {
//        let user = User()
//
//        do {
//
//            try db.collection("users").document(UserDefaults.standard.string(forKey: "id") ?? UUID().uuidString).setData(from: user)
//
//        } catch let error {
//            print("Error is : \(error)")
//        }
//    }
}
