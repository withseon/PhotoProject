//
//  PhotoCollectionViewCell.swift
//  PhotoProject
//
//  Created by 정인선 on 1/17/25.
//

import UIKit
import SnapKit

final class PhotoCollectionViewCell: BaseCollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let starCountView = StarCountView()
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(starCountView)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        starCountView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(8)
            make.height.equalTo(25)
        }
    }
}

extension PhotoCollectionViewCell {
    func updateContent(photo: Photo, isTopic: Bool = false) {
        imageView.setKFImage(strURL: photo.imageURLs.small)
        starCountView.updateContent(count: photo.likes)
        if isTopic {
            imageView.layer.cornerRadius = 10
        }
    }
}
