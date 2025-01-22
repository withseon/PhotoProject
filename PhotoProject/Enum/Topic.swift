//
//  Topic.swift
//  PhotoProject
//
//  Created by 정인선 on 1/17/25.
//

import Foundation

enum Topic: String, CaseIterable, Encodable {
    case architectureInterior = "architecture-interior"
    case goldenHour = "golden-hour"
    case wallpapers
    case nature
    case render3D = "3d-renders"
    case travel
    case texturesPatterns = "textures-patterns"
    case streetPhotography = "street-photography"
    case film
    case archival
    case experimental
    case animals
    case fashionBeauty = "fashion-beauty"
    case people
    case businessWork = "business-work"
    case foodDrink = "food-drink"
    
    var description: String {
        switch self {
        case .architectureInterior: return "건축 및 인테리어"
        case .goldenHour: return "골든 아워"
        case .wallpapers: return "배경 화면"
        case .nature: return "자연"
        case .render3D: return "3D 렌더링"
        case .travel: return "여행하다"
        case .texturesPatterns: return "텍스쳐 및 패턴"
        case .streetPhotography: return "거리 사진"
        case .film: return "필름"
        case .archival: return "기록의"
        case .experimental: return "실험적인"
        case .animals: return "동물"
        case .fashionBeauty: return "패션 및 뷰티"
        case .people: return "사람"
        case .businessWork: return "비즈니스 및 업무"
        case .foodDrink: return "식음료"
        }
    }
}
