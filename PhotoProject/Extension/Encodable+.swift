//
//  Encodable+.swift
//  PhotoProject
//
//  Created by 정인선 on 1/20/25.
//

import Foundation

extension Encodable {
    var toParameters : [String: Any]? {
        guard let object = try? JSONEncoder().encode(self) else { return nil }
        guard let parameters = try? JSONSerialization.jsonObject(with: object, options: []) as? [String: Any] else { return nil }
        return parameters
    }
}
