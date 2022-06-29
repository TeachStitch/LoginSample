//
//  LocalAuthenticationServiceHolder.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 01.07.2022.
//

import Foundation

protocol LocalAuthenticationServiceHolder {
    var localAuthenticationService: LocalAuthenticationServiceContext { get }
}
