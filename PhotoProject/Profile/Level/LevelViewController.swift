//
//  LevelViewController.swift
//  PhotoProject
//
//  Created by 정인선 on 1/23/25.
//

import UIKit

class LevelViewController: BaseViewController {
    private let mainView = LevelView()
    let levelTitles = ["상", "중", "하"]
    var level: Int?
    var delegate: ProfileDataDelegate?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSegmentControl()
    }
    
    override func configureNavigation() {
        navigationItem.title = "레벨"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
    }
    
    @objc
    private func okButtonTapped() {
        let level = mainView.segmentedControl.selectedSegmentIndex
        delegate?.levelDataReceived(level: level)
        navigationController?.popViewController(animated: true)
    }
}

extension LevelViewController {
    private func configureSegmentControl() {
        levelTitles.enumerated().forEach { index, title in
            mainView.segmentedControl.insertSegment(withTitle: title, at: index, animated: true)
        }
        guard let level else { return }
        mainView.segmentedControl.selectedSegmentIndex = level
    }
}
