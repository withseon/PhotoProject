//
//  Order.swift
//  PhotoProject
//
//  Created by 정인선 on 1/17/25.
//

import Foundation

enum Order: String, CaseIterable {
    case latest
    case relevant
    
    var title: String {
        switch self {
        case .latest:
            return "최신순"
        case .relevant:
            return "관련순"
        }
    }
}
