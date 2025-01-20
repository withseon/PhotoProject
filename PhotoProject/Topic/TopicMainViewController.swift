//
//  TopicMainViewController.swift
//  PhotoProject
//
//  Created by 정인선 on 1/17/25.
//

import UIKit

final class TopicMainViewController: BaseViewController {
    private struct TopicParams: Encodable {
        let client_id = APIKEY.ACCESS_KEY
        var query = ""
    }
    
    private let mainView = TopicMainView()
    // TODO: topicData 타입 변경
    private var topicData: [[Photo]] = [[],[],[]]
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.randomTopics.enumerated().forEach { index, topic in
            fetchTopicData(query: topic.rawValue, index: index)
        }
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
    private func fetchTopicData(query: String, index: Int) {
        let url = APIURL.SEARCH_URL
        let topicParams = TopicParams(query: query)
        let parameters = topicParams.toParameters
        
        NetworkManager.networkRequest(url: url, parameters: parameters, type: SearchPhoto.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                topicData[index] = success.results
                mainView.topicCollectionViews.forEach { collectionView in
                    collectionView.reloadData()
                }
            case .failure(let failure):
                print(failure)
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
