//
//  UserDefaultsServiceHolder.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 28.06.2022.
//

import Foundation

protocol UserDefaultsServiceHolder {
    var userDefaultsService: UserDefaultsServiceContext { get }
}
