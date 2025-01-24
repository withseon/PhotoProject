//
//  ProfileView.swift
//  PhotoProject
//
//  Created by 정인선 on 1/23/25.
//

import UIKit
import SnapKit

final class ProfileView: BaseView {
    let nicknameButton = UIButton()
    let birthdayButton = UIButton()
    let levelButton = UIButton()
    
    let nicknameLabel = UILabel()
    let birthdayLabel = UILabel()
    let levelLabel = UILabel()
    
    let saveButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "저장하기"
        config.baseBackgroundColor = .main
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        let button = UIButton()
        button.configuration = config
        return button
    }()
    
    override func configureHierarchy() {
        addSubview(nicknameButton)
        addSubview(birthdayButton)
        addSubview(levelButton)
        addSubview(nicknameLabel)
        addSubview(birthdayLabel)
        addSubview(levelLabel)
        addSubview(saveButton)
    }
    
    override func configureLayout() {
        nicknameButton.snp.makeConstraints { make in
            make.leading.top.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        birthdayButton.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(24)
            make.top.equalTo(nicknameButton.snp.bottom).offset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }

        levelButton.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(24)
            make.top.equalTo(birthdayButton.snp.bottom).offset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(24)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(nicknameButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }
        
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(24)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(birthdayButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }

        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(birthdayLabel.snp.bottom).offset(24)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(levelButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        nicknameButton.setTitleColor(.label, for: .normal)
        birthdayButton.setTitleColor(.label, for: .normal)
        levelButton.setTitleColor(.label, for: .normal)
        
        nicknameButton.setTitle("닉네임", for: .normal)
        birthdayButton.setTitle("생일", for: .normal)
        levelButton.setTitle("레벨", for: .normal)

        nicknameLabel.text = "NO NAME"
        nicknameLabel.textColor = .lightGray
        nicknameLabel.textAlignment = .right
        
        birthdayLabel.text = "NO DATE"
        birthdayLabel.textColor = .lightGray
        birthdayLabel.textAlignment = .right
        
        levelLabel.text = "NO LEVEL"
        levelLabel.textColor = .lightGray
        levelLabel.textAlignment = .right
    }
}

extension ProfileView {
    func updateNicknameLabel(text: String) {
        nicknameLabel.text = text.isEmpty ? "NO NAME" : text
        nicknameLabel.textColor = text.isEmpty ? .lightGray : .label
    }
    
    func updateBirthdayLabel(date: Date?) {
        if let date, let text = date.toFormattedString("yy년 MM월 dd일") {
            birthdayLabel.text = text
            birthdayLabel.textColor = .label
        }
    }
    
    func updateLevelLabel(level: Int?) {
        var text: String?
        if level == 0 {
            text = "상"
        } else if level == 1 {
            text = "중"
        } else {
            text = "하"
        }
        levelLabel.text = text
        levelLabel.textColor = .label
    }
}
