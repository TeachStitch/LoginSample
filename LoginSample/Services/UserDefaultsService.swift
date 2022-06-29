//
//  UserDefaultsService.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 28.06.2022.
//

import Foundation

protocol UserDefaultsServiceContext: AnyObject {
    var isLoggedIn: Bool { get set }
    var isFirstLaunch: Bool { get set }
    var token: String? { get set }
}

class UserDefaultsService: UserDefaultsServiceContext {
    
    @propertyWrapper
    struct Storage<T: Codable> {
        private let key: String
        private let defaultValue: T
        
        init(key: String, defaultValue: T) {
            self.key = key
            self.defaultValue = defaultValue
        }
        
        var wrappedValue: T {
            get {
                guard let data = UserDefaults.standard.object(forKey: key) as? Data,
                      let value = try? JSONDecoder().decode(T.self, from: data) else {
                    return defaultValue
                }
                return value
            }
            set {
                let data = try? JSONEncoder().encode(newValue)
                UserDefaults.standard.set(data, forKey: key)
            }
        }
    }
    
    @Storage(key: "arsenii.kovalenko.isloggedin.key", defaultValue: false)
    var isLoggedIn: Bool
    
    @Storage(key: "arsenii.kovalenko.token.key", defaultValue: nil)
    var token: String?
    
    @Storage(key: "arsenii.kovalenko.isFirstLaunch.key", defaultValue: true)
    var isFirstLaunch: Bool
}
