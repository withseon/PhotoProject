//
//  BaseView.swift
//  PhotoProject
//
//  Created by 정인선 on 1/17/25.
//

import UIKit

class BaseView: UIView {    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    func configureUI() {
        backgroundColor = .systemBackground
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() { }
    func configureLayout() { }
    func configureView() { }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
