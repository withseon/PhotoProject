//
//  Color.swift
//  PhotoProject
//
//  Created by 정인선 on 1/17/25.
//

import Foundation

enum Color: String, CaseIterable, Encodable {
    case black
    case white
    case yellow
    case red
    case purple
    case green
    case blue
    
    var description: String {
        switch self {
        case .black: return "블랙"
        case .white: return "화이트"
        case .yellow: return "옐로우"
        case .red: return "레드"
        case .purple: return "퍼플"
        case .green: return "그린"
        case .blue: return "블루"
        }
    }
    
    var colorHex: String {
        switch self {
        case .black: return "000000"
        case .white: return "FFFFFF"
        case .yellow: return "FFEF62"
        case .red: return "F04452"
        case .purple: return "9636E1"
        case .green: return "02B946"
        case .blue: return "3C59FF"
        }
    }
}
