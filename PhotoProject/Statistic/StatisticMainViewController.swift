//
//  StatisticMainViewController.swift
//  PhotoProject
//
//  Created by 정인선 on 1/19/25.
//

import UIKit

final class StatisticMainViewController: BaseViewController {
    private let mainView = StatisticMainView()
    var photo: Photo?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let photo else { return }
        fetchPhotoStatisticData(api: .statistic(id: photo.id))
    }
}

extension StatisticMainViewController {
    private func fetchPhotoStatisticData(api: UnsplashRequest) {
        UnsplashManager.executeFetch(api: api, type: StatisticsPhoto.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                guard let photo else { return }
                mainView.configureContent(photo: photo, statistics: success)
            case .failure(let failure):
                showAlert(title: failure.rawValue, withCancel: true)
            }
        }
    }
}
