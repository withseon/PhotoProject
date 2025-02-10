//
//  TopicMainViewController.swift
//  PhotoProject
//
//  Created by 정인선 on 1/17/25.
//

import UIKit

final class TopicMainViewController: BaseViewController {
    private let mainView = TopicMainView()
    private var randomTopics = Topic.allCases.shuffled().prefix(3).map { $0 }
    private var topicData: [[Photo]] = [[],[],[]]
    private var refreshTime: Date?
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureScrollView()
        fetchAllTopicData()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func configureNavigation() {
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "OUR TOPIC"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
    }
    
    override func configureCollectionView() {
        mainView.topicCollectionViews.forEach { collectionView in
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        }
    }
}

extension TopicMainViewController {
    private func configureScrollView() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshRandomTopic), for: .valueChanged)
        mainView.scrollView.refreshControl = refreshControl
    }
    
    @objc
    private func refreshRandomTopic() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self else { return }
            if refreshTime?.timeIntervalSinceNow ?? -60 <= -60 {
                refreshTime = Date.now
                randomTopics = Topic.allCases.shuffled().prefix(3).map { $0 }
                fetchAllTopicData()
            }
            mainView.scrollView.refreshControl?.endRefreshing()
        }
    }
}

extension TopicMainViewController {
    private func fetchAllTopicData() {
        let group = DispatchGroup()
        randomTopics.enumerated().forEach { index, topic in
            group.enter()
            fetchTopicData(api: UnsplashRequest.topic(id: topic.rawValue), index: index, group: group)
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            mainView.configureContent(topics: randomTopics)
            mainView.topicCollectionViews.forEach { collectionView in
                collectionView.reloadData()
            }
        }
    }
    
    private func fetchTopicData(api: UnsplashRequest, index: Int, group: DispatchGroup) {
        UnsplashManager.executeFetch(api: api, type: [Photo].self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                topicData[index] = success
                group.leave()
            case .failure(let failure):
                showAlert(withCancel: true, title: failure.rawValue)
                group.leave()
            }
        }
    }

}

extension TopicMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topicData[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { return BaseCollectionViewCell() }
        cell.updateContent(photo: topicData[collectionView.tag][indexPath.item], isTopic: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = StatisticMainViewController(photo: topicData[collectionView.tag][indexPath.item])
//        vc.photo = topicData[collectionView.tag][indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
}


