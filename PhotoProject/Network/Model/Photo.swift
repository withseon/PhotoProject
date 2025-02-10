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

// MARK: - 
extension Photo {
    var photoInfo: PhotoInfo {
        let createdDate = self.createdAt.toDate("yyyy-MM-dd'T'HH:mm:ssZ")
        let createdAt = createdDate?.toFormattedString("yyyy년 M월 d일 게시됨") ?? ""
        let userInfo = UserInfo(name: self.user.name,
                                profileImage: self.user.profileImage.medium)
        return PhotoInfo(id: self.id,
                         createdAt: createdAt,
                         heightToWidthRatio: Double(height) / Double(width),
                         size: "\(self.width) X \(self.height)",
                         rawImageURL: self.imageURLs.raw,
                         likes: self.likes,
                         userInfo: userInfo)
    }
}

struct PhotoInfo {
    let id: String
    let createdAt: String
    let heightToWidthRatio: Double
    let size: String
    let rawImageURL: String
    let likes: Int
    let userInfo: UserInfo
}

struct UserInfo {
    let name: String
    let profileImage: String
}
