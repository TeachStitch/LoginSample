//
//  LoginCoordinator.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 28.06.2022.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    enum Path {
        case loggedInFlow(token: String)
        case registerFlow
        case forgotPasswordFlow
    }
    
    private let serviceLocator: ServiceLocator
    private let rootViewController: UINavigationController
    
    init(serviceLocator: ServiceLocator,
         rootViewController: UINavigationController) {
        self.serviceLocator = serviceLocator
        self.rootViewController = rootViewController
    }
    
    func start() {
        let model = LoginModel(serviceLocator: serviceLocator)
        let viewModel = LoginViewModel(model: model) { path in
            switch path {
            case .loggedInFlow(let token):
                self.startLoggedInFlow(with: token)
            case .registerFlow:
                self.startRegisterFlow()
            case .forgotPasswordFlow:
                self.startForgotPasswordFlow()
            }
        }
        let viewController = LoginViewController(viewModel: viewModel)
        viewModel.delegate = viewController
        
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    private func startLoggedInFlow(with token: String) {
        
    }
    
    private func startRegisterFlow() {
        RegistrationCoordinator(serviceLocator: serviceLocator, rootViewController: rootViewController).start()
    }
    
    private func startForgotPasswordFlow() {
        ForgotPasswordCoordinator(serviceLocator: serviceLocator, rootViewController: rootViewController).start()
    }
}
