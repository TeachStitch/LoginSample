//
//  ForgotPasswordCoordinator.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import UIKit

class ForgotPasswordCoordinator: Coordinator {
    
    enum Path {
        case login
    }
    
    private let serviceLocator: ServiceLocator
    private let rootViewController: UINavigationController
    
    init(serviceLocator: ServiceLocator,
         rootViewController: UINavigationController) {
        self.serviceLocator = serviceLocator
        self.rootViewController = rootViewController
    }
    
    func start() {
        let model = ForgotPasswordModel()
        let viewModel = ForgotPasswordViewModel(model: model) { path in
            switch path {
            case .login:
                self.startLoginFlow()
            }
        }
        let viewController = ForgotPasswordViewController(viewModel: viewModel)
        viewModel.delegate = viewController
        
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    private func startLoginFlow() {
        
    }
}
