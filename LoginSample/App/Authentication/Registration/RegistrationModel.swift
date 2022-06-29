//
//  RegistrationModel.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import Foundation

protocol RegistrationModelProvider {
    func validateInput(_ text: String, of type: ValidationService.ValidationType) -> ValidationService.ValidationError?
}

class RegistrationModel: RegistrationModelProvider {
    
    typealias Context = UserDefaultsServiceHolder & ValidationServiceHolder
    
    private let userDefaultsService: UserDefaultsServiceContext
    private let validationService: ValidationServiceContext
    
    init(serviceLocator: Context) {
        userDefaultsService = serviceLocator.userDefaultsService
        validationService = serviceLocator.validationService
    }
    
    func validateInput(_ text: String, of type: ValidationService.ValidationType) -> ValidationService.ValidationError? {
        do {
            try validationService.validate(text, type: type)
            return nil
        }
        catch let error {
            guard let error = error as? ValidationService.ValidationError else { return nil }
            return error
        }
    }
}
