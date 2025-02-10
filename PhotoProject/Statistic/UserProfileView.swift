//
//  ProfileView.swift
//  PhotoProject
//
//  Created by 정인선 on 1/19/25.
//

import UIKit
import SnapKit

final class UserProfileView: BaseView {
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

extension UserProfileView {
    func configureContent(user: UserInfo, createAt: String) {
        profileImageView.setKFImage(strURL: user.profileImage)
        userNameLabel.text = user.name
        createDateLabel.text = createAt
    }
}
