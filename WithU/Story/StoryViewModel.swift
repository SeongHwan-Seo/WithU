//
//  StoryViewModel.swift
//  WithU
//
//  Created by SHSEO on 2022/09/13.
//

import Foundation
import SwiftUI
import Combine

class StoryViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var stories = [Story]()
    @Published var selectedImageStrings = [String]()
    @Published var images: [String : [UIImage]] = [:]
    @Published var isLoading = false
    @Published var isUploading = false
    @Published var detailSelectedImages: [URL] = []
    @Published var detailSelectedImage: URL? = nil
    @Published var detailShowViewer = false
    
    let firebaseService = FirebaseService.shared
     
    var didSendRequest: AnyPublisher<Void, Never> {
        subject.eraseToAnyPublisher()
    }
    
    private let subject = PassthroughSubject<Void, Never>()
    
    func createStory(story: Story, userId: String) {
        
        firebaseService.createStory(story: story, userId: userId)
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    return
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)
        
    }
    
    /// 스토리 글 수정
    /// - Parameters:
    ///   - story: story
    ///   - userId: userid
    func modifyStory(story: Story, userId: String) {
        
        firebaseService.createStory(story: story, userId: userId)
            .sink{ [weak self] (completion) in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    self.subject.send()
                    return
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)
        
    }
    
    /// 스토리이미지 업로드
    /// - Parameters:
    ///   - img: 스토리이미지 배열
    ///   - name: 이미지 이름
    func uploadStoryImage(img: [UIImage],imgName: [String], userId: String, storyId: String) {
        self.isUploading = true
        
        firebaseService.uploadImage(img: img, imgName: imgName ,dic: userId, storyId: storyId)
            .sink{ [weak self] (completion) in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    self.isUploading = false
                    self.subject.send()
                    return
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)
    }
    
    
    /// 스토리 가져오기
    /// - Parameter userId: 유저 아이디
    func loadStories(userId: String) {
        isLoading = true
        firebaseService.fetchStories(userId)
            .sink{ [weak self] (complition) in
                guard let self = self else { return }
                switch complition {
                case .failure(let error):
                    print("loadStories failure")
                    print(error)
                    return
                case .finished:
                    print("loadStories finished")
                    //self.getStoryImages(userId: userId)
                    self.isLoading = false
                    return
                }
            } receiveValue: { [weak self] (stories) in
                print("loadStories receiveValue")
                self?.stories = stories.sorted(by: {$0.createDate > $1.createDate})
            }
            .store(in: &cancellables)
    }
    
    func getStoryImages( userId: String) {
        if self.stories.count == 0 {
            self.isLoading = false
        } else {
            for story in self.stories{
                for idx in 0..<story.images.count {
                    firebaseService.fetchImages(imageName: story.images[idx], id: userId, storyId: story.id)
                        .sink{ [weak self] (completion) in
                            guard let self = self else { return }
                            switch completion {
                            case .failure(let error):
                                print(error)
                                return
                            case .finished:
                                self.isLoading = false
                                return
                            }
                        } receiveValue: { [weak self] (image) in
                            if self?.images[story.id] == nil {
                                self?.images[story.id] = [image]
                            } else {
                                if self?.images[story.id]?.count != story.images.count {
                                    self?.images[story.id]?.append(image)
                                }
                            }
                        }
                        .store(in: &cancellables)
                }

            }
        }
    }
    
    
    /// 스토리 삭제
    /// - Parameters:
    ///   - story: 스토리
    ///   - userId: 유저 아이디
    func deleteStory(story: Story, userId: String) {
        firebaseService.deleteStory(storyId: story.id, userId: userId)
            .sink{ [weak self] (completion) in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    return
                case .finished:
                    if let index = self.stories.firstIndex(of: story) {
                        self.stories.remove(at: index)
                    }
                    return
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    
    /// 스토리 이미지 삭제
    /// - Parameters:
    ///   - story: 스토리
    ///   - userId: 유저 아이디
    func deleteStoryImage(story: Story, userId: String) {
        firebaseService.deleteStoryImage(storyId: story.id, userId: userId)
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    return
                case .finished:
                    return
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
}


