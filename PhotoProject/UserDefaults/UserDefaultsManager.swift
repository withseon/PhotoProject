//
//  UserDefaultsManager.swift
//  PhotoProject
//
//  Created by 정인선 on 1/23/25.
//

import Foundation

struct UserDefaultsManager {
    @UserDefaultWrapper(key: "ONBOARDING", defaultValue: true)
    static var isFirstEnter: Bool?
    
    @UserDefaultWrapper(key: "PROFILE", defaultValue: nil)
    static var profileInfo: ProfileInfo?
}

@propertyWrapper
struct UserDefaultWrapper<T: Codable> {
    let key: String
    let defaultValue: T?
    
    init(key: String, defaultValue: T?) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T? {
        get {
            if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let savedObject = try? decoder.decode(T.self, from: savedData) {
                    return savedObject
                }
            }
            return defaultValue
        }
        set {
            if let newValue {
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(newValue) {
                    UserDefaults.standard.set(encoded, forKey: key)
                }
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
}
