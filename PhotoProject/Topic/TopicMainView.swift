//
//  TopicMainView.swift
//  PhotoProject
//
//  Created by 정인선 on 1/17/25.
//

import UIKit
import SnapKit

final class TopicMainView: BaseView {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private let firstTopicTitleLabel = UILabel()
    private let secondTopicTitleLabel = UILabel()
    private let thirdTopicTitleLabel = UILabel()
    private lazy var firstTopicCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setTopicCollectionViewFlowLayout())
    private lazy var secondTopicCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setTopicCollectionViewFlowLayout())
    private lazy var thirdTopicCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setTopicCollectionViewFlowLayout())
    var topicCollectionViews = [UICollectionView]()
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(firstTopicTitleLabel)
        scrollView.addSubview(secondTopicTitleLabel)
        scrollView.addSubview(thirdTopicTitleLabel)
        scrollView.addSubview(firstTopicCollectionView)
        scrollView.addSubview(secondTopicCollectionView)
        scrollView.addSubview(thirdTopicCollectionView)
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.verticalEdges.equalToSuperview()
        }
        firstTopicTitleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(20)
        }
        firstTopicCollectionView.snp.makeConstraints { make in
            make.top.equalTo(firstTopicTitleLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(250)
        }
        secondTopicTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(firstTopicCollectionView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        secondTopicCollectionView.snp.makeConstraints { make in
            make.top.equalTo(secondTopicTitleLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(250)
        }
        thirdTopicTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(secondTopicCollectionView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        thirdTopicCollectionView.snp.makeConstraints { make in
            make.top.equalTo(thirdTopicTitleLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(250)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    override func configureView() {
        let topicLabels = [firstTopicTitleLabel,
                           secondTopicTitleLabel,
                           thirdTopicTitleLabel]
        topicLabels.forEach { label in
            label.font = .systemFont(ofSize: 20, weight: .bold)
        }
        
        topicCollectionViews = [firstTopicCollectionView,
                                    secondTopicCollectionView,
                                    thirdTopicCollectionView]
        topicCollectionViews.enumerated().forEach { index, collectionView in
            collectionView.tag = index
        }
    }
}

// CollectionView Layout
extension TopicMainView {
    private func setTopicCollectionViewFlowLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let horizontalSpacing: CGFloat = 20
        let width = (UIScreen.main.bounds.width - (horizontalSpacing * 2)) / 2
        layout.itemSize = CGSize(width: width, height: width * 4 / 3)
        layout.sectionInset = UIEdgeInsets(top: 0, left: horizontalSpacing, bottom: 0, right: horizontalSpacing)
        layout.scrollDirection = .horizontal
        return layout
    }
}

extension TopicMainView {
    func configureContent(topics: [Topic]) {
        let topicLabels = [firstTopicTitleLabel, secondTopicTitleLabel, thirdTopicTitleLabel]
        topicLabels.enumerated().forEach { index, label in
            label.text = topics[index].description
            
        }
    }
}
