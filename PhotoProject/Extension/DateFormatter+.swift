//
//  DateFormatter+.swift
//  PhotoProject
//
//  Created by 정인선 on 1/19/25.
//

import UIKit

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "ko_KR")
        return dateFormatter
    }()
}
