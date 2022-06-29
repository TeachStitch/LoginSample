//
//  LoginViewModel.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 28.06.2022.
//

import Foundation

protocol LoginViewModelProvider: AnyObject {
    var biometryType: LocalAuthenticationService.BiometryType { get }
    
    func onLoad()
    func loginTapped()
    func registerTapped()
    func forgotPasswordTapped()
    func biometryTapped()
}

protocol LoginViewModelDelegate: AnyObject {
    func presentAlert(title: String, message: String)
}

class LoginViewModel: LoginViewModelProvider {
    
    typealias PathAction = (LoginCoordinator.Path) -> Void
    
    weak var delegate: LoginViewModelDelegate?
    
    var biometryType: LocalAuthenticationService.BiometryType {
        model.biometryType
    }
    
    private let model: LoginModelProvider
    private let pathAction: PathAction
    
    init(model: LoginModelProvider, pathAction: @escaping PathAction) {
        self.model = model
        self.pathAction = pathAction
    }
    
    func onLoad() {
        print(#function)
    }
    
    func loginTapped() {
        print(#function)
    }
    
    func registerTapped() {
        pathAction(.registerFlow)
    }
    
    func forgotPasswordTapped() {
        pathAction(.forgotPasswordFlow)
    }
    
    func biometryTapped() {
        model.authenticate { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.pathAction(.loggedInFlow(token: self.model.token))
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
    
    private func handleError(_ error: Error) {
        guard let error = error as? EvaluationError else { return }
        
        switch error {
        case .biometryLockout:
            delegate?.presentAlert(title: "Biometry is locked out", message: "You have recently several unsuccessful attempts. Try later again")
        case .userCancel:
            print("User cancelled")
        case .userFallback:
            print("User fallback")
        case .authenticationFailed:
            delegate?.presentAlert(title: "Authentication Failed", message: "Please, try to log in using your password")
        case .unknown(let string):
            delegate?.presentAlert(title: "Something went wrong", message: string)
        default: break
        }
    }
}
