//
//  MainNavigationController.swift
//  PhotoProject
//
//  Created by 정인선 on 1/19/25.
//

import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
}

extension MainNavigationController {
    private func configureAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .systemBackground
        navigationBarAppearance.shadowColor = .secondarySystemFill
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        
        let largeTitleAppearance = UINavigationBarAppearance()
        largeTitleAppearance.configureWithOpaqueBackground()
        largeTitleAppearance.backgroundColor = .systemBackground
        largeTitleAppearance.shadowColor = .clear
        UINavigationBar.appearance().scrollEdgeAppearance = largeTitleAppearance
        
        navigationBar.tintColor = .label
    }
}
