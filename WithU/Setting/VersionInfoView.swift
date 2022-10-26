//
//  VersionInfoView.swift
//  WithU
//
//  Created by SHSEO on 2022/10/26.
//

import SwiftUI

struct VersionInfoView: View {
    var body: some View {
        VStack{
            HStack {
                Text("현재버전")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.ForegroundColor)
                let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                if let version = version {
                    Text("v \(version)")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.ForegroundColor)
                }
                
//                Text("최신버전")
//                    .font(.system(size: 16, weight: .semibold, design: .rounded))
//                    .foregroundColor(.ForegroundColor)
//                Text("v \(loadAppStoreVersion())")
//                    .font(.system(size: 16, weight: .semibold, design: .rounded))
//                    .foregroundColor(.ForegroundColor)
                
            }
            
            
        }
    }
}

//fileprivate func loadAppStoreVersion() -> String {
//    let appID = "6444006977"
//    let appStoreUrl = "http://itunes.apple.com/kr/lookup?Id=\(appID)"
//    guard let data = try? Data(contentsOf: URL(string: appStoreUrl)!),
//        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//        let results = json["results"] as? [[String: Any]],
//        let appStoreVersion = results[0]["version"] as? String else {
//            return ""
//        }
//    return appStoreVersion
//
//
//}

struct VersionInfoView_Previews: PreviewProvider {
    static var previews: some View {
        VersionInfoView()
    }
}
