//
//  StarCountView.swift
//  PhotoProject
//
//  Created by 정인선 on 1/18/25.
//

import UIKit
import SnapKit

final class StarCountView: BaseView {
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .yellow
        return imageView
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "88,888"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override func configureHierarchy() {
        addSubview(starImageView)
        addSubview(countLabel)
    }
    
    override func configureLayout() {
        starImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(starImageView.snp.height)
        }

        countLabel.snp.makeConstraints { make in
            make.leading.equalTo(starImageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
    }
    
    override func configureView() {
        layer.backgroundColor = UIColor.darkGray.cgColor
        clipsToBounds = true
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            layer.cornerRadius = bounds.height / 2
        }
    }
}

extension StarCountView {
    func updateContent(count: Int) {
        countLabel.text = count.formatted()
    }
}
