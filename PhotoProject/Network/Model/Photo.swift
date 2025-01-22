//
//  Photo.swift
//  PhotoProject
//
//  Created by 정인선 on 1/17/25.
//

import Foundation

// MARK: - Search Data
struct SearchPhoto: Decodable {
    let total: Int
    let totalPages: Int
    let results: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

struct Photo: Decodable {
    let id: String
    let createdAt: String
    let width: Int
    let height: Int
    let imageURLs: ImageURL
    let likes: Int
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width
        case height
        case imageURLs = "urls"
        case likes
        case user
    }
}

struct ImageURL: Decodable {
    let raw: String
    let small: String
}

struct User: Decodable {
    let name: String
    let profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImage = "profile_image"
    }
}

struct ProfileImage: Decodable {
    let medium: String
}
