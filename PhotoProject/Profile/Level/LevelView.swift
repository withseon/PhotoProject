//
//  LevelView.swift
//  PhotoProject
//
//  Created by 정인선 on 1/23/25.
//

import UIKit
import SnapKit

final class LevelView: BaseView {
    let segmentedControl = UISegmentedControl()
    
    override func configureHierarchy() {
        addSubview(segmentedControl)
    }
    
    override func configureLayout() {
        segmentedControl.snp.makeConstraints { make in
            make.centerX.top.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).inset(24)
        }
    }
}
