//
//  AuthenticationModelProvider.swift
//  LocalAuthenticationSample
//
//  Created by Arsenii Kovalenko on 27.06.2022.
//

import Foundation

protocol AuthenticationModelProvider {
    var localizedReason: String? { get }
    var fallBackTitle: FallBackTitle { get }
    var cancelTitle: CancelTitle { get }
    var touchIDAuthenticationAllowableReuseDuration: TouchIDAllowableReuseDuration { get }
}
