//
//  NSObject+Extensions.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import Foundation

extension NSObject {
    static var identifier: String { "\(String(describing: Self.self))ID" }
}
