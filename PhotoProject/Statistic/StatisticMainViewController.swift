//
//  StatisticMainViewController.swift
//  PhotoProject
//
//  Created by 정인선 on 1/19/25.
//

import UIKit

final class StatisticMainViewController: BaseViewController {
    private let mainView = StatisticMainView()
    private let viewModel: StatisticMainViewModel
    
    init(photo: Photo) {
        viewModel = StatisticMainViewModel(photo: photo)
        viewModel.input.photoData.value = photo
        super.init()
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transform()
    }
    
    private func transform() {
        viewModel.output.updateContent.lazyBind { [weak self] content in
            guard let self, let content else { return }
            mainView.configureContent(photo: content.photo, statistics: content.statistics)
        }
        viewModel.output.showAlert.lazyBind { [weak self] message in
            guard let self else { return }
            showAlert(withCancel: true, message: message)
        }
    }
}
