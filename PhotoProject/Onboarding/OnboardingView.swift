//
//  OnboardingView.swift
//  PhotoProject
//
//  Created by 정인선 on 1/23/25.
//

import UIKit
import SnapKit

final class OnboardingView: BaseView {
    private let mainImageView = UIImageView()
    let startButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "시작하기"
        config.baseBackgroundColor = .main
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        let button = UIButton()
        button.configuration = config
        return button
    }()
    
    override func configureHierarchy() {
        addSubview(mainImageView)
        addSubview(startButton)
    }
    
    override func configureLayout() {
        mainImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalTo(safeAreaLayoutGuide)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        mainImageView.image = UIImage(named: "onboarding_image")
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.tintColor = .main
    }
}
