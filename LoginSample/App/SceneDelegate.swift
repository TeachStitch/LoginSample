//
//  SceneDelegate.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 28.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private(set) var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Register services
        let serviceLocator = ServiceLocator()
        registerUserDefaultsService(in: serviceLocator)
        registerValidationService(in: serviceLocator)
        registerLocalAuthenticationSrvice(in: serviceLocator)
        
        let window = UIWindow(windowScene: windowScene)
        let appCoordinator = AppCoordinator(window: window, serviceLocator: serviceLocator)
        
        appCoordinator.start()
        
        self.window = window
        self.appCoordinator = appCoordinator
        
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

extension SceneDelegate {
    private func registerUserDefaultsService(in serviceLocator: ServiceLocator) {
        let userDefaultService = UserDefaultsService()
        serviceLocator.register(userDefaultService)
    }
    
    private func registerValidationService(in serviceLocator: ServiceLocator) {
        let validationService = ValidationService()
        serviceLocator.register(validationService)
    }
    
    private func registerLocalAuthenticationSrvice(in serviceLocator: ServiceLocator) {
        let localAuthenticationService = LocalAuthenticationService()
        serviceLocator.register(localAuthenticationService)
    }
}
