//
//  ButtonTableViewCell.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import UIKit

protocol ButtonTableViewCellDelegate: AnyObject {
    func registrationButtonTapped()
    func loginButtonTapped()
}

class ButtonTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let loginButtonTitle = "ALREDY REGISTERED?"
        static let registrationButtonTitle = "REGISTER ACCOUNT"
        
        
        enum Layout {
            static let stackViewSpacing = 42.0
            static let stackViewHorizontalIndent = 32.0
            static let registrationButtonHeight = 42.0
        }
    }
    
    weak var delegate: ButtonTableViewCellDelegate?
    
    private lazy var registrationButton: PrimaryButton = {
        let button = PrimaryButton()
        button.setTitle(Constants.registrationButtonTitle, for: .normal)
        button.addTarget(self,
                         action: #selector(registrationButtonTapped),
                         for: .touchUpInside)
        button.isEnabled = false
        
        return button
    }()
    
    private lazy var loginButton: PrimaryButton = {
        let button = PrimaryButton(with: SecondaryPrimaryButtonConfiguration())
        button.setTitle(Constants.loginButtonTitle, for: .normal)
        button.addTarget(self,
                         action: #selector(loginButtonTapped),
                         for: .touchUpInside)
        
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            registrationButton,
            loginButton
        ])
        stackView.axis = .vertical
        stackView.spacing = Constants.Layout.stackViewSpacing
        stackView.alignment = .center
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
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.Layout.stackViewHorizontalIndent
            ),
            stackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.Layout.stackViewHorizontalIndent
            ),
            registrationButton.heightAnchor.constraint(equalToConstant: Constants.Layout.registrationButtonHeight),
            registrationButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            registrationButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
    
    @objc private func registrationButtonTapped() {
        delegate?.registrationButtonTapped()
    }
    
    @objc private func loginButtonTapped() {
        delegate?.loginButtonTapped()
    }
}

extension ButtonTableViewCell: ButtonEnabledDelegate {
    var isButtonEnabled: Bool {
        get {
            registrationButton.isEnabled
        }
        set(enabled) {
            registrationButton.isEnabled = enabled
        }
    }
}

