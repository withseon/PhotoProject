//
//  SearchMainView.swift
//  PhotoProject
//
//  Created by 정인선 on 1/17/25.
//

import UIKit
import SnapKit

final class SearchMainView: BaseView {
    lazy var colorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setColorCollectionViewCompositionalLayout())
    let sortButton = UIButton()
    private let centerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    lazy var photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setPhotoCollectionViewFlowLayout())
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sortButton.layer.cornerRadius = sortButton.bounds.height / 2
        sortButton.layer.maskedCorners = .ArrayLiteralElement(arrayLiteral: .layerMinXMinYCorner, .layerMinXMaxYCorner)
    }
    
    override func configureHierarchy() {
        addSubview(colorCollectionView)
        addSubview(sortButton)
        addSubview(centerLabel)
        addSubview(photoCollectionView)
    }
    
    override func configureLayout() {
        colorCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(32)
        }
        
        sortButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(colorCollectionView.snp.height)
            make.width.equalTo(92)
        }
        
        centerLabel.snp.makeConstraints { make in
            make.top.equalTo(colorCollectionView.snp.bottom)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        photoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(colorCollectionView.snp.bottom).offset(12)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    override func configureView() {
        sortButton.setTitle("관련순", for: .normal)
        sortButton.setTitle("최신순", for: .selected)
        sortButton.setTitleColor(.label, for: .normal)
        
        var config = UIButton.Configuration.plain()
        let imageConfig = UIImage.SymbolConfiguration(scale: .small)
        config.image = UIImage(systemName: "list.bullet", withConfiguration: imageConfig)
        config.imagePadding = 4
        config.baseBackgroundColor = .systemBackground
        config.baseForegroundColor = .label
        config.cornerStyle = .capsule
        sortButton.configuration = config
        sortButton.backgroundColor = .systemBackground
        sortButton.layer.borderColor = UIColor.secondarySystemFill.cgColor
        sortButton.layer.borderWidth = 1
    }
}

extension SearchMainView {
    func showCenterLabel(isStart: Bool) {
        if isStart {
            centerLabel.text = "사진을 검색해보세요."
        } else {
            centerLabel.text = "검색 결과가 없어요."
        }
        photoCollectionView.isHidden = true
    }
}

extension SearchMainView {
    private func setColorCollectionViewCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(50),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(50),
                                               heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 100)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setPhotoCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 10) / 2
        layout.itemSize = CGSize(width: width, height: width * 4 / 3)
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        return layout
    }
}
