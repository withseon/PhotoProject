//
//  ColorFilterCollectionViewCell.swift
//  PhotoProject
//
//  Created by 정인선 on 1/18/25.
//

import UIKit
import SnapKit

final class ColorFilterCollectionViewCell: BaseCollectionViewCell {
    private let colorView = UIView()
    private let colorLabel = UILabel()
    override var isSelected: Bool {
        willSet {
            setSelected(isSelected: newValue)
        }
    }
    
    override func configureHierarchy() {
        contentView.addSubview(colorView)
        contentView.addSubview(colorLabel)
    }
    
    override func configureLayout() {
        colorView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(4)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.width.equalTo(colorView.snp.height)
        }
        colorLabel.snp.makeConstraints { make in
            make.leading.equalTo(colorView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .secondarySystemFill
        clipsToBounds = true
        colorView.clipsToBounds = true
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            layer.cornerRadius = bounds.height / 2
            colorView.layer.cornerRadius = colorView.bounds.height / 2
            colorView.layer.borderColor = UIColor.secondarySystemFill.cgColor
            colorView.layer.borderWidth = 0.5
        }
        colorLabel.font = .systemFont(ofSize: 15)
    }
}

extension ColorFilterCollectionViewCell {
    private func setSelected(isSelected: Bool) {
        contentView.backgroundColor = isSelected ? .secondaryLabel : .secondarySystemFill
        colorLabel.textColor = isSelected ? .systemBackground : .label
    }
    
    func configureContent(color: Color) {
        colorView.backgroundColor = UIColor(hexCode: color.colorHex)
        colorLabel.text = color.description
    }
}
