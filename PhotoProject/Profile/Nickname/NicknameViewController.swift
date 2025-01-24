//
//  NicknameViewController.swift
//  PhotoProject
//
//  Created by 정인선 on 1/23/25.
//

import UIKit

class NicknameViewController: BaseViewController {
    private let mainView = NicknameView()
    var nickname: String?
    
    override func loadView() {
        view = mainView
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func configureView() {
        mainView.updateTextField(text: nickname)
    }
    
    override func configureNavigation() {
        navigationItem.title = "닉네임"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
    }
    
    @objc
    private func okButtonTapped() {
        if let trimmedText = mainView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !trimmedText.isEmpty {
            NotificationCenter.default.post(name: NSNotification.Name("Profile"),
                                            object: nil,
                                            userInfo: ["nickname": trimmedText])
            navigationController?.popViewController(animated: true)
        } else {
            showAlert(withCancel: false, message: "닉네임은 공백으로 이루어질 수 없습니다.", actionTitle: "확인")
        }
    }
}

