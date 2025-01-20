//
//  TopicMainView.swift
//  PhotoProject
//
//  Created by 정인선 on 1/17/25.
//

import UIKit
import SnapKit

final class TopicMainView: BaseView {
    let randomTopics = Topic.allCases.shuffled()[...2]
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    // TODO: 1. label, collectionView 타입 변경
    // TODO: 2. CollectionView - Section으로 구성
    private lazy var topicLabels: [UILabel] = {
        randomTopics.enumerated().map { index, topic in
            let label = UILabel()
            label.text = topic.description
            label.font = .systemFont(ofSize: 20, weight: .bold)
            label.tag = index
            return label
        }
    }()
    lazy var topicCollectionViews: [UICollectionView] = {
        randomTopics.enumerated().map { index, _ in
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setTopicCollectionViewFlowLayout())
            collectionView.tag = index
            return collectionView
        }
    }()
    
    override func configureHierarchy() {
        addSubview(scrollView)
        topicLabels.forEach { label in
            scrollView.addSubview(label)
        }
        topicCollectionViews.forEach { collectionView in
            scrollView.addSubview(collectionView)
        }
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        topicLabels[0].snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(20)
        }
        topicCollectionViews[0].snp.makeConstraints { make in
            make.top.equalTo(topicLabels[0].snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(250)
        }
        topicLabels[1].snp.makeConstraints { make in
            make.top.equalTo(topicCollectionViews[0].snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        topicCollectionViews[1].snp.makeConstraints { make in
            make.top.equalTo(topicLabels[1].snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(250)
        }
        
        topicLabels[2].snp.makeConstraints { make in
            make.top.equalTo(topicCollectionViews[1].snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        topicCollectionViews[2].snp.makeConstraints { make in
            make.top.equalTo(topicLabels[2].snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(250)
            make.bottom.equalToSuperview().inset(20)
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
