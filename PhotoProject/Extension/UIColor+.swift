//
//  UIColor+.swift
//  PhotoProject
//
//  Created by 정인선 on 1/18/25.
//

import UIKit

extension UIColor {
    convenience init?(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        guard hexFormatted.count == 6 else { return nil }
        
        var hexNumber: UInt64 = 0
        if  Scanner(string: hexFormatted).scanHexInt64(&hexNumber) {
            self.init(red: CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(hexNumber & 0x0000FF) / 255.0,
                      alpha: alpha)
            return
        }
        return nil
    }
}
