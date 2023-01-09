//
//  SettingViewModel.swift
//  WithU
//
//  Created by SHSEO on 2022/10/17.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

class SettingViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    let storeURL = URL(string: "itms-apps://itunes.apple.com/app/id6444006977")!
    let versionURL = "http://itunes.apple.com/kr/lookup?bundleId=com.seosh.WithU"
    @Published var isAnniversaryToggle = UserDefaults.standard.bool(forKey: "AnniversaryToggle")
    @Published var updatedVersion = ""
    
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
    
    /// 현재 버전 가져오기
    func getCurrentVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
        return version
    }
    
    /// 최신 버전 가져오기
    func getUpdatedVersion2() {
        AF.request(versionURL)
            .publishDecodable(type : Version.self)
            .compactMap{ $0.value}
            .map{ $0.results}
            .sink(receiveCompletion: { completion in
                print("Success get version info")
                
            }, receiveValue: { receivedValue in
                self.updatedVersion = receivedValue[0].version
                
            })
            .store(in: &cancellables)
        
        
    }
    
    
    func goToStore() {
        UIApplication.shared.open(storeURL)
    }
}
