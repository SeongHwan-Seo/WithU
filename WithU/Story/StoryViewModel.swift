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
    @Published var images: [String : UIImage?] = [:]
    
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
    
    
    /// 스토리 가져오가
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
                    return
                }
            } receiveValue: { [weak self] (stories) in
                self?.stories = stories.sorted(by: {$0.date < $1.date})
                print("receiveValue: ", stories)
                
            }
            .store(in: &cancellables)
    }
    
    
}
