//
//  BirthdayView.swift
//  PhotoProject
//
//  Created by 정인선 on 1/23/25.
//

import UIKit
import SnapKit

final class BirthdayView: BaseView {
    let datePicker = UIDatePicker()
    
    override func configureHierarchy() {
        addSubview(datePicker)
    }
    
    override func configureLayout() {
        datePicker.snp.makeConstraints { make in
            make.centerX.top.equalTo(safeAreaLayoutGuide)
        }
    }
}
