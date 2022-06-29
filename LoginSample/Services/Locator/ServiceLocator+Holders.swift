//
//  ServiceLocator+Holders.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 28.06.2022.
//

import Foundation

extension ServiceLocator {
    
    private enum Constants {
            static let errorMessage = "'%@' cannot be resolved"
    }
    
    var userDefaultsService: UserDefaultsServiceContext {
            guard let userDefaultsService: UserDefaultsService = self.resolve() else {
                fatalError(.init(format: Constants.errorMessage,
                                 arguments: [String(describing: UserDefaultsService.self)]))
            }
            return userDefaultsService
    }
    
    var validationService: ValidationServiceContext {
        guard let validationService: ValidationService = self.resolve() else {
            fatalError(.init(format: Constants.errorMessage,
                             arguments: [String(describing: ValidationService.self)]))
        }
        return validationService
    }
    
    var localAuthenticationService: LocalAuthenticationServiceContext {
        guard let localAuthenticationService: LocalAuthenticationService = self.resolve() else {
            fatalError(.init(format: Constants.errorMessage,
                             arguments: [String(describing: LocalAuthenticationService.self)]))
        }
        return localAuthenticationService
    }
}

extension ServiceLocator: UserDefaultsServiceHolder { }

extension ServiceLocator: ValidationServiceHolder { }

extension ServiceLocator: LocalAuthenticationServiceHolder { }
