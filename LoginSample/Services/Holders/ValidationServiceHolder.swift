//
//  ValidationServiceHolder.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import Foundation

protocol ValidationServiceHolder {
    var validationService: ValidationServiceContext { get }
}
