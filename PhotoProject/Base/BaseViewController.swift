//
//  BaseViewController.swift
//  PhotoProject
//
//  Created by 정인선 on 1/17/25.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigation()
        configureCollectionView()
    }
    
    func configureView() { }
    func configureNavigation() { }
    func configureCollectionView() { }
}
