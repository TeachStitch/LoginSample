//
//  LoginModelMock.swift
//  LoginSampleTests
//
//  Created by Arsenii Kovalenko on 01.07.2022.
//

import Foundation
@testable import LoginSample

class LoginModelMock: LoginModelProvider {
    
    var token: String = ""
    
    var biometryType: LocalAuthenticationService.BiometryType = .none
    
    func authenticate(completion: @escaping (Result<Void, EvaluationError>) -> Void) {
        token = "123321"
        switch biometryType {
        case .none:
            completion(.failure(.unknown("Test")))
        default:
            completion(.success(()))
        }
    }
}
