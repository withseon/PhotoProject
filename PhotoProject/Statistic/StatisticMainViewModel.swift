//
//  StatisticMainViewModel.swift
//  PhotoProject
//
//  Created by 정인선 on 2/10/25.
//

import Foundation

final class StatisticMainViewModel: BaseViewModel {
    private(set) var input: Input
    private(set) var output: Output
    private var photo: Photo
    
    struct Input {
        var photoData: Observable<Photo?> = Observable(nil)
    }
    
    struct Output {
        var updateContent: Observable<(photo: PhotoInfo, statistics: StatisticsInfo)?> = Observable(nil)
        var showAlert = Observable("")
    }
    
    init(photo: Photo) {
        self.photo = photo
        input = Input()
        output = Output()
        transform()
    }
    
    func transform() {
        input.photoData.bind { [weak self] photo in
            guard let self, let photo else { return }
            fetchPhotoStatisticData(api: UnsplashRequest.statistic(id: photo.id))
        }
    }
}

// MARK: -
extension StatisticMainViewModel {
    private func fetchPhotoStatisticData(api: UnsplashRequest) {
        UnsplashManager.executeFetch(api: api, type: StatisticsPhoto.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                output.updateContent.value = (photo.photoInfo, success.statisticsInfo)
                dump(success)
            case .failure(let failure):
                output.showAlert.value = failure.rawValue
            }
        }
    }
}
