//
//  PhotoStatic.swift
//  PhotoProject
//
//  Created by 정인선 on 1/17/25.
//

import Foundation

// MARK: - Static Data
struct StaticPhoto: Decodable {
    let id: String
    let downloads: DetailInfo
    let views: DetailInfo
}

struct DetailInfo: Decodable {
    let total: Int
    let historical: History
}

struct History: Decodable {
    let values: [ValueDetail]
}

struct ValueDetail: Decodable {
    let date: String
    let value: Int
}
