//
//  LoginViewController.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 28.06.2022.
//

import UIKit

class LoginViewController: UIViewController {

    private enum Constants {
        static let greetingsText = "Hello"
        static let ctaText = "Please log in to start using the app"
        static let emailTextFieldPlaceholder = "Email"
        static let passwordTextFieldPlaceholder = "Password"
        static let loginButtonText = "LOG IN"
        static let forgotPasswordButtonText = "FORGOT PASSWORD?"
        static let registerButtonText = "REGISTER NEW ACCOUNT"
        
        enum Layout {
            static let spacing = 30.0
            static let biometrySpacing = 8.0
            static let width = 296.0
            static let buttonHeight = 42.0
            static let textFieldHeight = 42.0
            static let forgotToRegisterSpacing = 150.0
            static let labelsSpacing = 10.0
            static let mainStackViewBottomIndent = 8.0
            static let registerButtonBottomIndent = 24.0
            static let registerButtonHeight = 24.0
            static let biometryButtonSize = CGSize(width: 42, height: 42)
        }
    }
    
    private let viewModel: LoginViewModelProvider
    
    private lazy var greetingsLabel: UILabel = {
        let greetings = UILabel()
        greetings.text = Constants.greetingsText
        greetings.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        greetings.textColor = UIColor.Assets.primary01
        greetings.translatesAutoresizingMaskIntoConstraints = false
        
        return greetings
    }()
    
    private lazy var ctaLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.ctaText
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor.Assets.text
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    private lazy var emailTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = Constants.emailTextFieldPlaceholder
        textField.validationType = .restrictedWhitespaces
        textField.addTarget(self, action: #selector(emailTextFieldEditingChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var passwordTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = Constants.passwordTextFieldPlaceholder
        textField.isSecureTextEntry = true
        textField.validationType = .restrictedWhitespaces
        textField.addTarget(self, action: #selector(passwordTextFieldEditingChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var loginButton: PrimaryButton = {
        let button = PrimaryButton()
        button.setTitle(Constants.loginButtonText, for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var biometryButton: PrimaryButton = {
        let button = PrimaryButton()
        button.addTarget(self, action: #selector(biometryButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        switch viewModel.biometryType {
        case .touchId:
            button.setImage(UIImage(systemName: "touchid"), for: .normal)
        case .faceId:
            button.setImage(UIImage(systemName: "faceid"), for: .normal)
        case .none:
            button.isHidden = true
        }
        
        return button
    }()
    
    private lazy var loginStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            biometryButton,
            loginButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = Constants.Layout.biometrySpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var forgotPasswordButton: PrimaryButton = {
        let button = PrimaryButton(with: SecondaryPrimaryButtonConfiguration())
        button.setTitle(Constants.forgotPasswordButtonText, for: .normal)
        button.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var registerButton: PrimaryButton = {
        let button = PrimaryButton(with: SecondaryPrimaryButtonConfiguration())
        button.setTitle(Constants.registerButtonText, for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            greetingsLabel,
            ctaLabel,
            emailTextField,
            passwordTextField,
            loginStackView,
            forgotPasswordButton
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = Constants.Layout.spacing
        stackView.setCustomSpacing(Constants.Layout.labelsSpacing, after: greetingsLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()

    
    init(viewModel: LoginViewModelProvider) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        setUpAutoLayoutConstraints()
        viewModel.onLoad()
        
    }
    
    private func setUpSubviews() {
        view.backgroundColor = .Assets.background
        view.addSubview(mainStackView)
        view.addSubview(registerButton)
    }
    
    private func setUpAutoLayoutConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: registerButton.topAnchor, constant: -Constants.Layout.mainStackViewBottomIndent),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            emailTextField.widthAnchor.constraint(equalToConstant: Constants.Layout.width),
            passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            
            loginButton.widthAnchor.constraint(equalToConstant: Constants.Layout.width),
            loginButton.heightAnchor.constraint(equalToConstant: Constants.Layout.buttonHeight),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: Constants.Layout.registerButtonHeight),
            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.Layout.registerButtonBottomIndent),
            
            biometryButton.heightAnchor.constraint(equalToConstant: Constants.Layout.biometryButtonSize.height),
            biometryButton.widthAnchor.constraint(equalToConstant: Constants.Layout.biometryButtonSize.width)
        ])
    }
    
    @objc private func emailTextFieldEditingChanged() {
        
    }
    
    @objc private func passwordTextFieldEditingChanged() {
        
    }
    
    @objc private func loginButtonTapped() {
        viewModel.loginTapped()
    }
    
    @objc private func forgotPasswordButtonTapped() {
        viewModel.forgotPasswordTapped()
    }
    
    @objc private func registerButtonTapped() {
        viewModel.registerTapped()
    }
    
    @objc private func biometryButtonTapped() {
        viewModel.biometryTapped()
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
