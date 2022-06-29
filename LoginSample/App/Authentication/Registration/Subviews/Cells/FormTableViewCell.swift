//
//  FormTableViewCell.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import UIKit

protocol FormTableViewCellDelegate: AnyObject {
    func getFullNameText(text: String)
    func getUsernameText(text: String)
    func getPasswordText(text: String)
}

class FormTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let fullNamePlaceholder = "Full Name"
        static let fullNameHelperText = "Will be visible to other users"
        static let fullNameErrorText = "Please fill in your name"
        
        static let emailPlaceholder = "Email"
        static let emailHelperText = "We will send a verification link to it"
        
        static let passwordPlaceholder = "Password"
        static let passwordHelperText = "Min 6 characters long, uppercase+lowercase+numbers"
        
        static let maxCountOfCharacterFullNameText = 32
        
        enum Layout {
            static let spacing = 16.0
            static let stackViewHorizontalIndent = 32.0
            static let stackViewTopIndent = 30.0
        }
    }
    
    weak var delegate: FormTableViewCellDelegate?
    
    private lazy var fullNameTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = Constants.fullNamePlaceholder
        textField.helperText = Constants.fullNameHelperText
//        textField.errorText = Constants.fullNameErrorText
        textField.autoCorrectionType = .no
        textField.autocapitalizationType = .words
        textField.textContentType = .name
        textField.maxCountOfCharacters = Constants.maxCountOfCharacterFullNameText
        textField.validationType = .fullName
        textField.addTarget(self,
                            action: #selector(editingFullNameTextFieldDidEnd),
                            for: .editingDidEnd)
        
        return textField
    }()
    
    private lazy var emailTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = Constants.emailPlaceholder
        textField.helperText = Constants.emailHelperText
        textField.autocapitalizationType = .none
        textField.autoCorrectionType = .no
        textField.textContentType = .emailAddress
        textField.validationType = .restrictedWhitespaces
        textField.keyboardType = .emailAddress
        textField.addTarget(self,
                            action: #selector(editingEmailTextFieldDidEnd),
                            for: .editingDidEnd)
        
        return textField
    }()
    
    private lazy var passwordTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = Constants.passwordPlaceholder
        textField.helperText = Constants.passwordHelperText
        textField.isSecureTextEntry = true
        textField.autoCorrectionType = .no
        textField.validationType = .restrictedWhitespaces
//        textField.textContentType = .newPassword
        textField.addTarget(self,
                            action: #selector(editingPasswordTextFieldDidEnd),
                            for: .editingDidEnd)
        
        return textField
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            fullNameTextField,
            emailTextField,
            passwordTextField
        ])
        stackView.spacing = Constants.Layout.spacing
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubviews()
        setUpLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpSubviews() {
        contentView.addSubview(stackView)
    }
    
    private func setUpLayoutConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.Layout.stackViewTopIndent
            ),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.Layout.stackViewHorizontalIndent
            ),
            stackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.Layout.stackViewHorizontalIndent
            )
        ])
    }
    
    @objc private func editingFullNameTextFieldDidEnd() {
        guard let text = fullNameTextField.text else { return }
        delegate?.getFullNameText(text: text)
    }
    
    @objc private func editingEmailTextFieldDidEnd() {
        guard let text = emailTextField.text else { return }
        delegate?.getUsernameText(text: text)
    }
    
    @objc private func editingPasswordTextFieldDidEnd() {
        guard let text = passwordTextField.text else { return }
        delegate?.getPasswordText(text: text)
    }
}

extension FormTableViewCell: FormValidationStatusDelegate {
    func setFullNameValid(_ isValid: Bool, reason: String?) {
        fullNameTextField.errorText = reason
        fullNameTextField.currentState = isValid ? .normal : .error
    }
    
    func setEmailValid(_ isValid: Bool, reason: String?) {
        emailTextField.errorText = reason
        emailTextField.currentState = isValid ? .normal : .error
    }
    
    func setPasswordValid(_ isValid: Bool, reason: String?) {
        passwordTextField.errorText = reason
        passwordTextField.currentState = isValid ? .normal : .error
    }
}

