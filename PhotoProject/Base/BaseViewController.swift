//
//  BaseViewController.swift
//  PhotoProject
//
//  Created by 정인선 on 1/17/25.
//

import UIKit

class BaseViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigation()
        configureCollectionView()
    }
    
    func configureView() { }
    func configureNavigation() { }
    func configureCollectionView() { }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
