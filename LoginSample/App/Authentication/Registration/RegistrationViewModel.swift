//
//  RegistrationViewModel.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import Foundation

protocol RegistrationViewModelProvider: AnyObject {
    func updateFullNameText(_ fullNameText: String)
    func updateEmailText(_ emailText: String)
    func updatePasswordText(_ passwordText: String)
    func updateCheckBoxSelection(_ isSelected: Bool)
    
    func onLoad()
    func registrationTapped()
    func loginTapped()
    
}

protocol RegistrationViewModelDelegate: AnyObject {
    func setRegistrationEnabled(_ isEnabled: Bool)
    func setFullNameTextValidation(_ isValid: Bool, reason: String?)
    func setEmailTextValidation(_ isValid: Bool, reason: String?)
    func setPasswordTextValidation(_ isValid: Bool, reason: String?)
    func setCheckBoxSelection(_ isSelected: Bool)
    
}

class RegistrationViewModel: RegistrationViewModelProvider {
    
    typealias PathAction = (RegistrationCoordinator.Path) -> Void
    
    weak var delegate: RegistrationViewModelDelegate?
    
    private let model: RegistrationModelProvider
    private let pathAction: PathAction
    private var registrationData = RegistrationData()
    
    private var isFullNameValid: Bool {
        model.validateInput(registrationData.fullName, of: .fullName(.default)) == nil
    }
    
    private var isUsernameValid: Bool {
        model.validateInput(registrationData.email, of: .email(.default)) == nil
    }
    
    private var isPasswordValid: Bool {
        model.validateInput(registrationData.password, of: .password(.default)) == nil
    }
    
    private var isCheckBoxSelected = false {
        didSet {
            delegate?.setCheckBoxSelection(isCheckBoxSelected)
            registrationData.isConsent = isCheckBoxSelected
        }
    }
    
    
    init(model: RegistrationModelProvider, pathAction: @escaping PathAction) {
        self.model = model
        self.pathAction = pathAction
    }
    
    func onLoad() {}
    
    func updateFullNameText(_ fullNameText: String) {
        registrationData.fullName = fullNameText
        guard let error = model.validateInput(fullNameText, of: .fullName(.default)) else {
            delegate?.setFullNameTextValidation(true, reason: nil)
            checkRegistrationButtonAvailability()
            return
        }
        delegate?.setFullNameTextValidation(false, reason: error.reason)
    }
    
    func updateEmailText(_ emailText: String) {
        registrationData.email = emailText
        guard let error = model.validateInput(emailText, of: .email(.default)) else {
            delegate?.setEmailTextValidation(true, reason: nil)
            checkRegistrationButtonAvailability()
            return
        }
        delegate?.setEmailTextValidation(false, reason: error.reason)
    }
    
    func updatePasswordText(_ passwordText: String) {
        registrationData.password = passwordText
        guard let error = model.validateInput(passwordText, of: .password(.default)) else {
            delegate?.setPasswordTextValidation(true, reason: nil)
            checkRegistrationButtonAvailability()
            return
        }
        delegate?.setPasswordTextValidation(false, reason: error.reason)
    }
    
    func updateCheckBoxSelection(_ isSelected: Bool) {
        isCheckBoxSelected = isSelected
        checkRegistrationButtonAvailability()
    }
    
    func registrationTapped() {
        print(#function)
    }
    
    func loginTapped() {
        pathAction(.login)
    }
    
    private func checkRegistrationButtonAvailability() {
        let isEnabled = isFullNameValid &&
        isUsernameValid &&
        isPasswordValid &&
        isCheckBoxSelected
        delegate?.setRegistrationEnabled(isEnabled)
    }
}
