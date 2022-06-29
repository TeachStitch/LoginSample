//
//  LoginModel.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 28.06.2022.
//

import Foundation

protocol LoginModelProvider {
    var token: String { get }
    var biometryType: LocalAuthenticationService.BiometryType { get }
    func authenticate(completion: @escaping (_ result: Result<Void,EvaluationError>) -> Void)
}

class LoginModel: LoginModelProvider {
    
    typealias Context = UserDefaultsServiceHolder & LocalAuthenticationServiceHolder
    
    var token = String()
    
    var biometryType: LocalAuthenticationService.BiometryType {
        localAuthenticationService.biometryType
    }
    
    private let userDefaultsService: UserDefaultsServiceContext
    private let localAuthenticationService: LocalAuthenticationServiceContext
    
    init(serviceLocator: Context) {
        userDefaultsService = serviceLocator.userDefaultsService
        localAuthenticationService = serviceLocator.localAuthenticationService
    }
    
    func authenticate(completion: @escaping (_ result: Result<Void,EvaluationError>) -> Void) {
        let reason = "We need your biometry to log in"
        localAuthenticationService.requestAuthentication(.biometricsOnly, reason: reason) { [weak self] result in
            switch result {
            case .success:
                self?.userDefaultsService.isLoggedIn = true
                self?.userDefaultsService.token = "123456789"
                self?.token = "123456789"
                completion(.success(()))
            case .failure(let error):
                switch error {
                case .systemCancel:
                    completion(.failure(.systemCancel))
                case .appCancel:
                    completion(.failure(.appCancel))
                case .passcodeNotSet:
                    completion(.failure(.passcodeNotSet))
                case .biometryNotAvailable:
                    completion(.failure(.biometryNotAvailable))
                case .biometryNotEnrolled:
                    completion(.failure(.biometryNotEnrolled))
                case .biometryLockout:
                    completion(.failure(.biometryLockout))
                case .userCancel:
                    completion(.failure(.userCancel))
                case .userFallback:
                    completion(.failure(.userFallback))
                case .authenticationFailed:
                    completion(.failure(.authenticationFailed))
                case .unknown(let reason):
                    print(reason)
                }
            }
        }
    }
}
