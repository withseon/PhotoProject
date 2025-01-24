//
//  OnboardingViewController.swift
//  PhotoProject
//
//  Created by 정인선 on 1/23/25.
//

import UIKit

final class OnboardingViewController: BaseViewController {
    private let mainView = OnboardingView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        configureButton()
    }
}

extension OnboardingViewController {
    private func configureButton() {
        mainView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func startButtonTapped() {
        UserDefaultsManager.isFirstEnter = false
        let vc = MainNavigationController(rootViewController: ProfileViewController())
        changeRootViewController(vc: vc)
    }
}
