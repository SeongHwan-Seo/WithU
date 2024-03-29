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
import FirebaseAuth

class FirebaseService {
    static let shared = FirebaseService()
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    /// 파이어베이스 익명로그인
    /// - Returns: String
    func anonymousLogin() -> AnyPublisher<String, Error> {
        
        Future<String, Error> { promise in
            print("anonymousLogin Start")
            Auth.auth().signInAnonymously{ authResult, error in
                if let error = error {
                    print("anonymousLogin ERROR : \(error)")
                    promise(.failure(error))
                    return
                }
                
                promise(.success(authResult?.user.uid ?? ""))
                
            }
        }
        .eraseToAnyPublisher()
    }
    
    /// 유저정보 불러오기
    /// - Returns: User
    func fetchUser() -> AnyPublisher<User, Error> {
        Future<User, Error> { [weak self] promise in
            guard let self = self else { return }
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
    
    /// 유저정보저장
    /// - Parameter user: 유저
    /// - Returns: void
    func setUser(_ user: User) -> AnyPublisher<Void, Error> {
        Future<Void,  Error> { [weak self] promise in
            guard let self = self else { return }
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
    func uploadImage(img: UIImage, name: String, dic: String) -> AnyPublisher<Void, Error>{
        Future<Void, Error> { [weak self] promise in
            guard let self = self else { return }
            let storageRef = self.storage.reference().child("images/\(dic)/\(name)")
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
    /// - Returns: void
    func uploadImage(img: [UIImage],imgName: [String], dic: String, storyId: String) -> AnyPublisher<Void, Error>{
        Future<Void, Error> { [weak self] promise in
            guard let self = self else { return }
            let metaData = StorageMetadata()
            metaData.contentType = "Image/png"
            for idx in 0..<img.count{
                let storageRef = self.storage.reference().child("images/\(dic)/story/\(storyId)/\(imgName[idx])")
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
    
    
    /// FireStorage에서 이미지 가져오기
    /// - Parameters:
    ///   - imageName: 이미지 명
    ///   - id: 유저아이디
    /// - Returns: UIImage
    func fetchImage(imageName: String, id: String) -> AnyPublisher<UIImage, Error> {
        Future<UIImage, Error> { [weak self] promise in
            guard let self = self else { return }
            let ref = self.storage.reference().child("images/\(id)/" + "\(imageName)")
            
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
    
    /// 기념일 생성
    /// - Parameters:
    ///   - anniversary: 기념일
    ///   - userId: 유저아이디
    /// - Returns: void
    func createAnniversary(_ anniversary: Anniversary, _ userId: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            guard let self = self else { return }
            guard let id = anniversary.id,
                  let title = anniversary.title,
                  let date = anniversary.date else {
                return
            }
            self.db.collection("users").document(userId).collection("anniversary")
                .document(id).setData([
                    "id": id,
                    "title": title,
                    "date": date
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
    
    /// 기념일 가져오기
    /// - Parameter userId: 유저아이디
    /// - Returns: [Anniversary]
    func fetchAnniversaries(_ userId: String) -> AnyPublisher<[Anniversary], Error> {
        
        Future<[Anniversary], Error> { [weak self] promise in
            guard let self = self else { return }
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
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeZone = TimeZone(abbreviation: "KST")
                    dateFormatter.locale = Locale(identifier:"ko_KR")
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    
                    let today = Date()
                    snapshot.documents.forEach { document in
                        if let anniversary = try? document.data(as: Anniversary.self) {
                            if anniversaries.contains(where: { $0.id == anniversary.id}) { return }
                            guard let date = anniversary.date else { return }
                            if !UserDefaults.standard.bool(forKey: "AnniversaryToggle")
                            {
                                if let targetDate: Date = dateFormatter.date(from: date),
                                   let todayDate: Date = dateFormatter.date(from: today.toString()!) {
                                    switch targetDate.compare(todayDate) {
                                    case .orderedAscending: return
                                    case .orderedSame:
                                        break
                                    case .orderedDescending:
                                        break
                                    }
                                }
                                
                            }
                            anniversaries.append(anniversary)
                            
                            
                        }
                    }
                    
                    promise(.success(anniversaries))
                }
            
            
        }
        .eraseToAnyPublisher()
    }
    
    
    /// 기념일 삭제
    /// - Parameters:
    ///   - anniversaryId: 기념일 아이디
    ///   - userId: 유저 아이디
    /// - Returns: void
    func deleteAnniversary(_ anniversaryId: String, _ userId: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            guard let self = self else { return }
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
    
    
    /// 스토리 생성
    /// - Parameters:
    ///   - story: 스토리
    ///   - userId: 유저 아이디
    /// - Returns: void
     func createStory(story: Story, userId: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            guard let self = self else { return }
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
            
            
        }
        .eraseToAnyPublisher()
    }
    
    
    /// 스토리삭제
    /// - Parameters:
    ///   - storyId: 스토리아이디
    ///   - userId: 유저아디디
    /// - Returns: void
    func deleteStory(storyId: String, userId: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            guard let self = self else { return }
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
    func fetchStories(_ userId: String) -> AnyPublisher<[Story], Error> {
        return Future<[Story], Error> { [weak self] promise in
            guard let self = self else { return }
            self.db.collection("users").document(userId).collection("story")
                .getDocuments{ (snapshot, error) in
                    if let error = error {
                        promise(.failure(error))
                        return
                    }
                    
                    guard let snapshot = snapshot else {
                        
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
        .flatMap { stories in
            return Future<[Story], Error> { [weak self] promise in
                guard let self = self else { return }
                if stories.count == 0 { promise(.success([]))} //스토리가 존재하지 않는다면 리턴
                var results = [Story]()
                let dispatchGroup = DispatchGroup()
                
                for story in stories {
                    var newStory = story
                    var urls = [URL]()
                    
                    for image in story.images {
                        dispatchGroup.enter()
                        
                        let ref = self.storage.reference().child("images/\(userId)/story/\(story.id)/" + "\(image)")
                        
                        ref.downloadURL(completion: { url, err in
                            if let err = err {
                                print("FirebaseService - fetchStories() : downloadURL Error - \(err.localizedDescription)")
                                promise(.failure(err))
                                return
                            }
                            
                            if let url = url {
                                urls.append(url)
                            }
                            
                            dispatchGroup.leave()
                        })
                    }
                    
                    dispatchGroup.notify(queue: .main) {
                        newStory.url = urls
                        results.append(newStory)
                        
                        if results.count == stories.count {
                            promise(.success(results))
                        }
                    }
                }
            }
            .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
    
    
    /// 이미지 여러장 가져오기
    /// - Parameters:
    ///   - imageName: 이미지 이름 배열
    ///   - id: 유저 아이디
    /// - Returns: 이미지
    func fetchImages(imageName: String, id: String, storyId: String) -> AnyPublisher<UIImage, Error> {
        Future<UIImage, Error> { [weak self] promise in
            guard let self = self else { return }
            
            let ref = self.storage.reference().child("images/\(id)/story/\(storyId)/" + "\(imageName)")
            
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
    func deleteStoryImage(storyId: String, userId: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            guard let self = self else { return }
            let ref = self.storage.reference().child("images/\(userId)/story/\(storyId)")
            
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
    
    
    /// 모든정보삭제
    /// - Parameter userId: 유저아이디
    /// - Returns: void
    func deleteAllInfo(userId: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            guard let self = self else { return }
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
            
            var ref = self.storage.reference().child("images/\(userId)/")
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
            
            ref = self.storage.reference().child("images/\(userId)/story/")
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
