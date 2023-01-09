//
//  Version.swift
//  WithU
//
//  Created by SHSEO on 2023/01/09.
//

import Foundation

// MARK: - Version
struct Version: Codable {
    let resultCount: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let version: String
}
