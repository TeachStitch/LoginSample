//
//  BaseTextField.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 28.06.2022.
//

import UIKit

protocol BaseTextFieldConfigurable {
    var activeColor: UIColor { get }
    var disableColor: UIColor { get }
    var errorColor: UIColor { get }
    var eyeButtonActiveColor: UIColor { get }
    var eyeButtonDisableColor: UIColor { get }
    var activePlaceholderFont: UIFont { get }
    var disablePlaceholderFront: UIFont { get }
    var helperTextFont: UIFont { get }
}

class BaseTextField: UIView {
    
    enum State {
        case normal
        case error
    }
    
    enum ValidationType {
        case unspecified
        case numbers
        case letters
        case phoneNumber
        case alphaNumeric
        case fullName
        case restrictedWhitespaces
    }
    
    private enum Constants {
        static let stackViewSpacing = 2.0
        static let textFieldHeight = 48.0
        static let textFieldBoarderWidth = 1.0
        static let textFieldCornerRadius = 4.0
        static let textFieldLeftIndent = 16.0
        static let animationDuration = 0.5
        static let buttonImagePadding = 13.0
        static let placeholderDelta = 32.0
    }
    
    var validationType: ValidationType = .unspecified
    var errorText: String?
    var maxCountOfCharacters: Int?
    
    var isSecureTextEntry: Bool = false {
        didSet {
            guard isSecureTextEntry else { return }
            setPasswordButton()
        }
    }
    
    var placeholder: String? {
        didSet {
            guard let placeholder = placeholder else { return }
            placeholderLabel.text = " \(placeholder) "
        }
    }
    
    var helperText: String? {
        didSet {
            helperTextLabel.text = helperText
        }
    }
    
    var currentState: State = .normal {
        didSet {
            updateUI(for: currentState)
        }
    }
    
    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    var autoCorrectionType: UITextAutocorrectionType {
        get { textField.autocorrectionType }
        set { textField.autocorrectionType = newValue }
    }
    
    var autocapitalizationType: UITextAutocapitalizationType {
        get { textField.autocapitalizationType }
        set { textField.autocapitalizationType = newValue }
    }
    
    var textContentType: UITextContentType {
        get { textField.textContentType }
        set { textField.textContentType = newValue }
    }
    
    var keyboardType: UIKeyboardType {
        get { textField.keyboardType }
        set { textField.keyboardType = newValue }
    }
    
    private let configuration: BaseTextFieldConfigurable
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = Constants.textFieldBoarderWidth
        textField.layer.borderColor = configuration.disableColor.cgColor
        textField.layer.cornerRadius = Constants.textFieldCornerRadius
        textField.leftView = UIView(frame: CGRect(
            x: .zero,
            y: .zero,
            width: Constants.textFieldLeftIndent,
            height: Constants.textFieldLeftIndent))
        textField.leftViewMode = .always
        
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
        
        return textField
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = configuration.disablePlaceholderFront
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var helperTextLabel: UILabel = {
        let label = UILabel()
        label.font = configuration.helperTextFont
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = .zero
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(helperTextLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var passwordButton: UIButton = {
        let configuration = UIButton.Configuration.borderless()
        let button = UIButton(configuration: configuration)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = self.configuration.eyeButtonDisableColor
        button.addTarget(self, action: #selector(passwordButtonTapped(_:)), for: .touchUpInside)
        button.configuration?.imagePadding = Constants.buttonImagePadding
        
        return button
    }()
    
    init(with configuration: BaseTextFieldConfigurable = DefaultBaseTextFieldConfiguration()) {
        self.configuration = configuration
        super.init(frame: .zero)
        setupSubviews()
        setupAutoLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTarget(_ target: Any?, action: Selector, for state: UIControl.Event) {
        textField.addTarget(target, action: action, for: state)
    }
    
    private func setupSubviews() {
        addSubview(stackView)
        addSubview(placeholderLabel)
    }
    
    private func setupAutoLayoutConstraints() {
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            
            placeholderLabel.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.textFieldLeftIndent)
        ])
    }
    
    private func updateUI(for state: State) {
        switch state {
        case .normal:
            helperTextLabel.text = helperText
            helperTextLabel.textColor = configuration.activeColor
            textField.layer.borderColor = configuration.activeColor.cgColor
        case .error:
            helperTextLabel.text = errorText
            helperTextLabel.textColor = configuration.errorColor
            textField.layer.borderColor = configuration.errorColor.cgColor
        }
    }
    
    private func setPasswordButton() {
        textField.rightView = passwordButton
        textField.rightViewMode = .always
        textField.isSecureTextEntry.toggle()
    }
    
    private func verifyText(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text, let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        switch validationType {
        case .unspecified:
            break
        case .numbers:
            guard string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil else { return false }
        case .letters:
            guard string.rangeOfCharacter(from: CharacterSet.letters.inverted) == nil else { return false }
        case .phoneNumber:
            let characterSet = CharacterSet(charactersIn: "+0123456789")
            guard string.rangeOfCharacter(from: characterSet.inverted) == nil else { return false }
        case .alphaNumeric:
            guard string.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil else { return false }
        case .fullName:
            let characterSet = CharacterSet.letters.union(.init(charactersIn: "- "))
            guard string.rangeOfCharacter(from: characterSet.inverted) == nil else { return false }
        case .restrictedWhitespaces:
            let restrictedCharacterSet = CharacterSet.whitespacesAndNewlines
            guard string.rangeOfCharacter(from: restrictedCharacterSet) == nil else { return false }
        }
        
        guard let maxCount = maxCountOfCharacters else { return true }
        return updatedText.count <= maxCount
    }
    
    @objc private func textFieldEditingDidBegin() {
        if currentState != .error {
            textField.layer.borderColor = configuration.activeColor.cgColor
        }
        
        guard let text = textField.text, text.isEmpty else { return }
        placeholderLabel.font = configuration.activePlaceholderFont
        
        UIView.animate(withDuration: Constants.animationDuration,
                       delay: .zero,
                       options: .curveEaseOut) { [weak self] in
            self?.placeholderLabel.transform = CGAffineTransform(translationX: 0, y: -Constants.placeholderDelta)
        }
    }
    
    @objc private func textFieldEditingDidEnd() {
        textField.layer.borderColor = configuration.disableColor.cgColor
        
        guard let text = textField.text, text.isEmpty else { return }
        placeholderLabel.font = configuration.disablePlaceholderFront
        
        UIView.animate(withDuration: Constants.animationDuration,
                       delay: .zero,
                       options: .curveEaseOut) { [weak self] in
            self?.placeholderLabel.transform = .identity
        }
    }
    
    @objc private func passwordButtonTapped(_ sender: UIButton) {
        sender.tintColor = textField.isSecureTextEntry ?
        configuration.eyeButtonActiveColor : configuration.eyeButtonDisableColor
        textField.isSecureTextEntry.toggle()
    }
}

extension BaseTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        verifyText(textField, shouldChangeCharactersIn: range, replacementString: string)
    }
}
