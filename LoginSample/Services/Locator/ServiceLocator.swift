//
//  ServiceLocator.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 28.06.2022.
//

import Foundation

final class ServiceLocator {
    private var services = [ObjectIdentifier: Any]()

    func register<T>(_ service: T) {
        services[key(for: T.self)] = service
    }

    func resolve<T>() -> T? {
        return services[key(for: T.self)] as? T
    }

    private func key<T>(for type: T.Type) -> ObjectIdentifier {
        return ObjectIdentifier(T.self)
    }
}
