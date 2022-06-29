//
//  LoginViewModelDelegateMock.swift
//  LoginSampleTests
//
//  Created by Arsenii Kovalenko on 01.07.2022.
//

import Foundation
@testable import LoginSample

class LoginViewModelDelegateMock: LoginViewModelDelegate {
    
    var isPresentAlertTriggered = false
    
    func presentAlert(title: String, message: String) {
        isPresentAlertTriggered = true
    }
}
