//
//  UserDfaultsExtension.swift
//  WithU
//
//  Created by SHSEO on 2023/01/10.
//

import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
            let appGroupId = "group.com.seosh.WithU"
            return UserDefaults(suiteName: appGroupId)!
        }
}
