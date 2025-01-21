//
//  TopicMainViewController.swift
//  PhotoProject
//
//  Created by 정인선 on 1/17/25.
//

import UIKit

final class TopicMainViewController: BaseViewController {
    private let mainView = TopicMainView()
    private let randomTopics = Array(Topic.allCases.shuffled()[...2])
    private var topicData: [[Photo]] = [[],[],[]]
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllTopicData()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
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
        NetworkManager.networkRequest(url: api.endPoint,
                                      method: api.method,
                                      parameters: api.parameters,
                                      headers: api.header,
                                      type: [Photo].self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let value):
                topicData[index] = value
                group.leave()
            case .failure(let error):
                print(error)
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
        let vc = StatisticMainViewController()
        vc.photo = topicData[collectionView.tag][indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
}
