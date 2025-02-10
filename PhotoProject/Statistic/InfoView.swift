//
//  InfoView.swift
//  PhotoProject
//
//  Created by 정인선 on 1/19/25.
//

import UIKit
import SnapKit

final class InfoView: BaseView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "정보"
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    private lazy var sizeTitleLabel = createSubTitleLabel(title: "크기")
    private lazy var viewsTitleLabel = createSubTitleLabel(title: "조회수")
    private lazy var downloadTitleLabel = createSubTitleLabel(title: "다운로드")
    private let sizeValueLabel = UILabel()
    private let viewsValueLabel = UILabel()
    private let downloadValueLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(sizeTitleLabel)
        addSubview(viewsTitleLabel)
        addSubview(downloadTitleLabel)
        addSubview(sizeValueLabel)
        addSubview(viewsValueLabel)
        addSubview(downloadValueLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        sizeTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(4)
            make.centerY.equalTo(titleLabel)
        }
        sizeValueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(sizeTitleLabel)
        }
        viewsTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(sizeTitleLabel)
            make.top.equalTo(sizeTitleLabel.snp.bottom).offset(4)
        }
        viewsValueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(viewsTitleLabel)
        }
        downloadTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(viewsTitleLabel)
            make.top.equalTo(viewsTitleLabel.snp.bottom).offset(4)
        }
        downloadValueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(downloadTitleLabel)
        }
    }
    
    override func configureView() {
        sizeValueLabel.textAlignment = .right
        viewsValueLabel.textAlignment = .right
        downloadValueLabel.textAlignment = .right
    }
}

extension InfoView {
    private func createSubTitleLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }
    
    func configureContent(size: String, views: String, downLoad: String) {
        sizeValueLabel.text = size
        viewsValueLabel.text = views
        downloadValueLabel.text = downLoad
    }
}
