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
    let storeURL = URL(string: "itms-apps://itunes.apple.com/app/id6444006977")!
    @Published var isAnniversaryToggle = UserDefaults.standard.bool(forKey: "AnniversaryToggle")
    
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
        func getUpdatedVersion() -> String {
            guard let url = URL(string: "http://itunes.apple.com/kr/lookup?bundleId=com.seosh.WithU"),
                  let data = try? Data(contentsOf: url),
                  let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                  let results = json["results"] as? [[String: Any]],
                      results.count > 0,
                let appStoreVersion = results[0]["version"] as? String else { return "" }
            return appStoreVersion
        }
    
    func goToStore() {
        UIApplication.shared.open(storeURL)
    }
}
