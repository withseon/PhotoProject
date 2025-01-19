//
//  String+.swift
//  PhotoProject
//
//  Created by 정인선 on 1/19/25.
//

import UIKit

extension String {
    func toDate(_ dateFormat: String = "yyyy-MM-dd(EEEEE) a HH:mm") -> Date? {
        let dateFormatter = DateFormatter.dateFormatter
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)
    }
}
