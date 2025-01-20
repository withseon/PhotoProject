//
//  StatisticMainViewController.swift
//  PhotoProject
//
//  Created by 정인선 on 1/19/25.
//

import UIKit

final class StatisticMainViewController: BaseViewController {
    private struct StatisticParams: Encodable {
        let client_id = APIKEY.ACCESS_KEY
    }
    private let mainView = StatisticMainView()
    private let statisticParams = StatisticParams()
    var photo: Photo?
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let photo else { return }
        fetchPhotoStatisticData(imageID: photo.id)
    }
    
    override func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension StatisticMainViewController {
    private func fetchPhotoStatisticData(imageID: String) {
        let url = APIURL.STATISTIC_URL + "\(imageID)/statistics"
        let parameters = statisticParams.toParameters
        
        NetworkManager.networkRequest(url: url, parameters: parameters, type: StatisticsPhoto.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                guard let photo else { return }
                mainView.configureContent(photo: photo, statistics: success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
