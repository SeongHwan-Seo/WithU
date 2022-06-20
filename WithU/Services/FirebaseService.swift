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
            self.db.collection("USERS").document(UserDefaults.standard.string(forKey: "id")!)
                .getDocument { (snapshot, error) in
                    if let error = error {
                        promise(.failure(error))
                        return
                    }
                    guard let snapshot = snapshot else {
                        promise(.failure(FirebaseError.badSnapshot))
                        return
                    }
                    print(snapshot.data().map(String.init(describing:)) ?? "nil")
                    
                    if let user = try? snapshot.data(as: User.self) {
                        
                    }
                }
        }
        .eraseToAnyPublisher()
    }
    
    static func setUser() {
        let user = User()
        
        do {
            try db.collection("users").document(UserDefaults.standard.string(forKey: "id") ?? UUID().uuidString).setData(from: user)
        } catch let error {
            print("Error is : \(error)")
        }
    }
}
