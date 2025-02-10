//
//  PhotoStatic.swift
//  PhotoProject
//
//  Created by 정인선 on 1/17/25.
//

import Foundation

// MARK: - Statistics Data
struct StatisticsPhoto: Decodable {
    let id: String
    let downloads: Detail
    let views: Detail
}

struct Detail: Decodable {
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

// MARK: -
extension StatisticsPhoto {
    var statisticsInfo: StatisticsInfo {
        let downloads = DetailInfo(total: self.downloads.total.formatted(),
                                   history: self.downloads.historical)
        let views = DetailInfo(total: self.views.total.formatted(),
                               history: self.views.historical)
        return StatisticsInfo(id: self.id,
                              downloads: downloads,
                              views: views)
    }
}

struct StatisticsInfo {
    let id: String
    let downloads: DetailInfo
    let views: DetailInfo
}

struct DetailInfo {
    let total: String
    let history: History
}
