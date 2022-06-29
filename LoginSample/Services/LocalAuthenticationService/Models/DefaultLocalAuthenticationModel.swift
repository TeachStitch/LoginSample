//
//  DefaultLocalAuthenticationModel.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 01.07.2022.
//

import Foundation

struct DefaultLocalAuthenticationModel: AuthenticationModelProvider {
    let localizedReason: String? = "We need your biometry to log in"
    let fallBackTitle: FallBackTitle = .default
    let cancelTitle: CancelTitle = .default
    let touchIDAuthenticationAllowableReuseDuration: TouchIDAllowableReuseDuration = .restricted
}
