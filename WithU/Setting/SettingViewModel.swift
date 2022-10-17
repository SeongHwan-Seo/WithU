//
//  SettingViewModel.swift
//  WithU
//
//  Created by SHSEO on 2022/10/17.
//

import Foundation
import SwiftUI
import Combine

class SettingViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    func deleteAll(userId: String) {
        FirebaseService.deleteAllInfo(userId: userId)
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
}
