//
//  ProfileViewController.swift
//  PhotoProject
//
//  Created by 정인선 on 1/23/25.
//

import UIKit

protocol ProfileDataDelegate {
    func levelDataReceived(level: Int)
}

final class ProfileViewController: BaseViewController {
    private let mainView = ProfileView()
    private var nickname: String = "" {
        didSet {
            updateSaveButtonState()
        }
    }
    private var birthday: Date? {
        didSet {
            updateSaveButtonState()
        }
    }
    private var level: Int? {
        didSet {
            updateSaveButtonState()
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(receivedNotification),
                                               name: NSNotification.Name("Profile"),
                                               object: nil)
        if let savedProfileInfo = UserDefaultsManager.profileInfo {
            nickname = savedProfileInfo.name
            birthday = savedProfileInfo.birth
            level = savedProfileInfo.level
            mainView.updateNicknameLabel(text: nickname)
            mainView.updateBirthdayLabel(date: birthday)
            mainView.updateLevelLabel(level: level)
        }
        updateSaveButtonState()
    }
    
    @objc
    private func receivedNotification(value: NSNotification) {
        guard let userInfo = value.userInfo else { return }
        if let nickname = userInfo["nickname"] as? String {
            self.nickname = nickname
            mainView.updateNicknameLabel(text: nickname)
        }
    }
    
    override func configureNavigation() {
        navigationItem.title = "프로필 화면"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "탈퇴하기", style: .plain, target: self, action: #selector(withdrawalButtonTapped))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
    }
    
    @objc
    private func withdrawalButtonTapped() {
        showAlert(withCancel: true, message: "탈퇴하시겠습니까?", actionTitle: "확인") { [weak self] in
            guard let self else { return }
            UserDefaultsManager.profileInfo = nil
            UserDefaultsManager.isFirstEnter = true
            changeRootViewController(vc: OnboardingViewController())
        }
    }
}

extension ProfileViewController {
    private func configureButton() {
        mainView.nicknameButton.addTarget(self, action: #selector(nicknameButtonTapped), for: .touchUpInside)
        mainView.birthdayButton.addTarget(self, action: #selector(birthdayButtonTapped), for: .touchUpInside)
        mainView.levelButton.addTarget(self, action: #selector(levelButtonTapped), for: .touchUpInside)
        mainView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func nicknameButtonTapped() {
        let vc = NicknameViewController()
        vc.nickname = nickname
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func birthdayButtonTapped() {
        let vc = BirthdayViewController()
        vc.birthday = birthday
        vc.contents = { [weak self] date in
            guard let self else { return }
            birthday = date
            mainView.updateBirthdayLabel(date: date)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func levelButtonTapped() {
        let vc = LevelViewController()
        vc.level = level
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func saveButtonTapped() {
        showAlert(withCancel: true, message: "저장하시겠습니까?", actionTitle: "확인") { [weak self] in
            guard let self else { return }
            guard let birthday, let level, !nickname.isEmpty else { return }
            let profileInfo = ProfileInfo(name: nickname, birth: birthday, level: level)
            UserDefaultsManager.profileInfo = profileInfo
            changeRootViewController(vc: MainTabBarController())
        }
    }
    
    private func updateSaveButtonState() {
        if nickname.isEmpty || birthday == nil || level == nil {
            mainView.saveButton.isEnabled = false
        } else {
            mainView.saveButton.isEnabled = true
        }
    }
}

extension ProfileViewController: ProfileDataDelegate {
    func levelDataReceived(level: Int) {
        self.level = level
        mainView.updateLevelLabel(level: level)
    }
}
