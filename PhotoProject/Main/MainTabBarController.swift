//
//  MainTabBarController.swift
//  PhotoProject
//
//  Created by 정인선 on 1/19/25.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
        configureTabBarAppearance()
    }
}

extension MainTabBarController {
    private func configureTabBarController() {
        let firstNav = MainNavigationController(rootViewController: TopicMainViewController())
        firstNav.tabBarItem.image = UIImage(systemName: "chart.line.uptrend.xyaxis")
        
        let secondNav = MainNavigationController(rootViewController: SearchMainViewController())
        secondNav.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        setViewControllers([firstNav, secondNav], animated: true)
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .systemBackground
        appearance.shadowColor = .secondarySystemBackground
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .label
    }
}

