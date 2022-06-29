//
//  AppCoordinator.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 28.06.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let serviceLocator: ServiceLocator
    
    private let rootViewController = UINavigationController()
    
    init(window: UIWindow,
         serviceLocator: ServiceLocator) {
        self.window = window
        self.window.rootViewController = rootViewController
        self.serviceLocator = serviceLocator
    }
    
    func start() {
        serviceLocator.userDefaultsService.isFirstLaunch ?
        RegistrationCoordinator(serviceLocator: serviceLocator, rootViewController: rootViewController).start() :
        LoginCoordinator(serviceLocator: serviceLocator, rootViewController: rootViewController).start()
        
        serviceLocator.userDefaultsService.isFirstLaunch = false
    }
}
