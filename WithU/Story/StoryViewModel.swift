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
    @Published var images: [String : [URL]] = [:]
    @Published var isLoading = false
    
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

        FirebaseService.uploadImage(img: img, imgName: imgName ,dic: userId, storyId: storyId)
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    return
                }
            } receiveValue: { _ in }
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
                    self.getImageURL()
                    //self.isLoading = false
                    
                    return
                }
            } receiveValue: { [weak self] (stories) in
                self?.isLoading = true
                self?.stories = stories.sorted(by: {$0.date < $1.date})
                
                
            }
            .store(in: &cancellables)
    }
    
    func setStoryImages(imgName: [String], userId: String, storyId: String) {
        FirebaseService.fetchImages(imageName: imgName, id: userId, storyId: storyId)
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    if self.stories.count == self.images.count {
                        self.isLoading = false
                    }
                    
                    return
                }
            } receiveValue: { [weak self] (image) in
                
                //self?.images[storyId] = image
            }
            .store(in: &cancellables)
    }
    
//    func getImageURL(imgName: [String], userId: String, storyId: String)  {
//        FirebaseService.getImageURL(imageName: imgName, id: userId, storyId: storyId)
//            .sink{ (completion) in
//                switch completion {
//                case .failure(let error):
//                    print(error)
//                    return
//                case .finished:
//                    self.isLoading = false
//                    return
//                }
//            } receiveValue: { url in
//                self.images[storyId] = url
//            }
//            .store(in: &cancellables)
//    }
    
    func getImageURL() {
//        for story in self.stories {
//            self.images[story.id] = FirebaseService.getImageURL(imageName: story.images, id: UserDefaults.standard.string(forKey: "id")!, storyId: story.id)
//        }
        for story in self.stories {
            FirebaseService.getImageURL(imageName: story.images, id: UserDefaults.standard.string(forKey: "id")!, storyId: story.id)
                .sink{ (completion) in
                    switch completion {
                    case .failure(let error) :
                        print(error)
                        return
                    case .finished:
                        self.isLoading = false
                        return
                    }
                } receiveValue: { url in
                    self.images[story.id] = url
                }
                .store(in: &cancellables)
        }
        
    }

    
    
    
}
