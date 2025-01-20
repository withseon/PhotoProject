//
//  ProfileView.swift
//  PhotoProject
//
//  Created by 정인선 on 1/19/25.
//

import UIKit
import SnapKit

final class ProfileView: BaseView {
    private let profileImageView = UIImageView()
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    private let userNameLabel = UILabel()
    private let createDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    override func layoutSubviews() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
    }
    
    override func configureHierarchy() {
        addSubview(profileImageView)
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(userNameLabel)
        labelStackView.addArrangedSubview(createDateLabel)
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview()
            make.size.equalTo(44)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
            make.centerY.trailing.equalToSuperview()
        }
    }
    
    override func configureView() {
        backgroundColor = .clear
        profileImageView.clipsToBounds = true
    }
}

extension ProfileView {
    func configureContent(user: User, createAt: String) {
        profileImageView.setKFImage(strURL: user.profileImage.medium)
        userNameLabel.text = user.name
        createDateLabel.text = createAt
            .toDate("yyyy-MM-dd'T'HH:mm:ssZ")?
            .toFormattedString("yyyy년 M월 d일 게시됨")
    }
}
