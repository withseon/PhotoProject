//
//  BirthdayViewController.swift
//  PhotoProject
//
//  Created by 정인선 on 1/23/25.
//

import UIKit

class BirthdayViewController: BaseViewController {
    private let mainView = BirthdayView()
    var birthday: Date?
    var contents: ((Date) -> Void)?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatePicker()
    }
    
    override func configureNavigation() {
        navigationItem.title = "생일"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
    }
    
    @objc
    private func okButtonTapped() {
        print(#function)
        contents?(mainView.datePicker.date)
        navigationController?.popViewController(animated: true)
    }
}

extension BirthdayViewController {
    private func configureDatePicker() {
        mainView.datePicker.preferredDatePickerStyle = .wheels
        mainView.datePicker.datePickerMode = .date
        mainView.datePicker.maximumDate = Date()
        guard let birthday else { return }
        mainView.datePicker.setDate(birthday, animated: true)
    }
}
