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
    
    func createStory(story: Story, userId: String) {
        
        FirebaseService.createStory(story: story, userId: userId)
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
    
    /// 스토리이미지 업로드
    /// - Parameters:
    ///   - img: 스토리이미지 배열
    ///   - name: 이미지 이름
    func uploadStoryImage(img: [UIImage],imgName: [String], userId: String, storyId: String) {
        self.isUploading = true
        
        FirebaseService.uploadImage(img: img, imgName: imgName ,dic: userId, storyId: storyId)
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    self.isUploading = false
                    return
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)
    }
    
    
    /// 스토리 가져오기
    /// - Parameter userId: 유저 아이디
    func loadStories(userId: String) {
        print(#function)
        FirebaseService.fetchStories(userId)
            .sink{ (complition) in
                switch complition {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    
                    self.getStoryImages(userId: userId)
                    //self.isLoading = false
                    
                    return
                }
            } receiveValue: { [weak self] (stories) in
                self?.isLoading = true
                self?.stories = stories.sorted(by: {$0.date < $1.date})
                
                
            }
            .store(in: &cancellables)
    }
    
    func getStoryImages( userId: String) {
        if self.stories.count == 0 {
            self.isLoading = false
        } else {
            for story in self.stories{
                for idx in 0..<story.images.count {
                    FirebaseService.fetchImages(imageName: story.images[idx], id: userId, storyId: story.id)
                        .sink{ (completion) in
                            switch completion {
                            case .failure(let error):
                                print(error)
                                return
                            case .finished:
                                self.isLoading = false
                                print(self.isLoading)
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
    

    func deleteStory(story: Story, userId: String) {
        FirebaseService.deleteStory(storyId: story.id, userId: userId)
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    return
                case .finished:
                    if let index = self.stories.firstIndex(of: story) {
                        self.stories.remove(at: index)
                    }
                    print("Finish deleteStory")
                    return
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    func deleteStoryImage(story: Story, userId: String) {
        FirebaseService.deleteStoryImage(storyId: story.id, userId: userId)
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    return
                case .finished:
                    print("Finish deleteStoryImage")
                    return
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    
   
}


