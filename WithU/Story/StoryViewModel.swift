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
    @Published var detailSelectedImage: String = ""
    @Published var detailShowViewer = false
    @Published var detailViewerOffset: CGSize = .zero
    @Published var detailBgOpacity: Double = 1
    
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
    
    
    /// 스토리 수정
    /// - Parameters:
    ///   - storyId: 스토리 아이디
    ///   - storyContent: 스토리 컨텐트
    ///   - userId: 유저 아이디
    func modifyStory(storyId: String, storyContent: String, userId: String) {
        
        firebaseService.modifyStory(storyId: storyId, storyContent: storyContent, userId: userId)
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
                    print(error)
                    return
                case .finished:
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
    func deleteStory(storyId: String, userId: String) {
        firebaseService.deleteStory(storyId: storyId, userId: userId)
            .sink{ [weak self] (completion) in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    return
                case .finished:
                    if let index = self.stories.firstIndex(where: { $0.id == storyId}) {
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
    func deleteStoryImage(storyId: String, userId: String) {
        firebaseService.deleteStoryImage(storyId: storyId, userId: userId)
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
    
    
    /// DetailImagesView 드래그 변화
    /// - Parameter value: 드래그 height
    func onChange(value: CGSize) {
        
        let halgHeight = UIScreen.main.bounds.height / 2
        let progress = value.height / halgHeight
        DispatchQueue.main.async { [self] in
            withAnimation(.default) {
                detailBgOpacity = Double(1 - (progress < 0 ? -progress : progress))
            }
        }
        
    }
    
    
    ///DetailImagesView 드래그 끝
    /// - Parameter value: 드래그 heght
    func onEnd(value: DragGesture.Value) {
        withAnimation(.default) {
            var translation = value.translation.height
            
            if translation < 0 {
                translation = -translation
            }
            
            if translation < 200 {
                self.detailViewerOffset = .zero
                self.detailBgOpacity = 1
            }
            else {
                self.detailShowViewer.toggle()
                
                
            }
            
        }
        self.detailViewerOffset = .zero
        self.detailBgOpacity = 1
        
    }
}


