//
//  RegistrationCoordinator.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import UIKit

class RegistrationCoordinator: Coordinator {
    
    enum Path {
        case login
        case main
    }
    
    private let serviceLocator: ServiceLocator
    private let rootViewController: UINavigationController
    
    init(serviceLocator: ServiceLocator,
         rootViewController: UINavigationController) {
        self.serviceLocator = serviceLocator
        self.rootViewController = rootViewController
    }
    
    func start() {
        let model = RegistrationModel(serviceLocator: serviceLocator)
        let viewModel = RegistrationViewModel(model: model) { path in
            switch path {
            case .login:
                self.startLogInFlow()
            case .main:
                self.startMainFlow()
            }
        }
        let viewController = RegistrationViewController(viewModel: viewModel)
        viewModel.delegate = viewController
        
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    private func startLogInFlow() {
        LoginCoordinator(serviceLocator: serviceLocator, rootViewController: rootViewController).start()
    }
    
    private func startMainFlow() {
        
    }
}
