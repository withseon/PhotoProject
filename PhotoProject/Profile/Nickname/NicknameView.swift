//
//  NicknameView.swift
//  PhotoProject
//
//  Created by 정인선 on 1/23/25.
//

import UIKit
import SnapKit

final class NicknameView: BaseView {
    let textField = UITextField()
    
    override func configureHierarchy() {
        addSubview(textField)
    }
    
    override func configureLayout() {
        textField.snp.makeConstraints { make in
            make.centerX.top.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).inset(24)
        }
    }
    
    override func configureView() {
        textField.placeholder = "닉네임을 입력해주세요"
    }
}

extension NicknameView {
    func updateTextField(text: String?) {
        textField.text = text
    }
}
