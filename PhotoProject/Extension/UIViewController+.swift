//
//  UIViewController+.swift
//  PhotoProject
//
//  Created by 정인선 on 1/19/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String? = nil, message: String? = nil,
                   style: UIAlertController.Style = .alert,
                   actionTitle: String? = nil, actionHandler: (() -> Void)? = nil,
                   withCancel: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        if withCancel {
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(cancelAction)
        }
        if let actionTitle {
            let action = UIAlertAction(title: actionTitle, style: .default) { _ in
                actionHandler?()
            }
            alert.addAction(action)
        }
        self.present(alert, animated: true)
    }
}
