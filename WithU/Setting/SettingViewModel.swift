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
                    print("Failed deleteAll : \(error)")
                    return
                case .finished:
                    print("Success deleteAll")
                    UserDefaults.standard.set(nil, forKey: "id")
                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        exit(0)
                    }
                    return
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)
    }
}
