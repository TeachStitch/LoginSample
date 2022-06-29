//
//  CheckBoxTableViewCell.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import UIKit

protocol CheckBoxTableViewCellDelegate: AnyObject {
    func updateCheckBoxSelection(_ isSelected: Bool)
}

class CheckBoxTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let checkBoxLabelText = "I explicitly consent to App collecting and processing user data specified above"
        static let errorLabelText = "Please give your consent to data processing to continue"
        
        enum Layout {
            static let stackViewSpacing = 10.0
            static let stackViewHorizontalIndent = 32.0
            static let stackViewTopIndent = 8.0
            static let checkBoxLabelNumberOfLines = 3
            static let errorLabelTopIndent = 38.0
            static let checkBoxSize = 16.0
            static let mainSpacing = 10.0
        }
    }
    
    weak var delegate: CheckBoxTableViewCellDelegate?
    
    private lazy var checkBoxButton: CheckBoxButton = {
        let button = CheckBoxButton()
        button.addTarget(self,
                         action: #selector(touchUpInsideButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var checkBoxLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.checkBoxLabelText
        label.numberOfLines = Constants.Layout.checkBoxLabelNumberOfLines
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        return label
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.errorLabelText
        label.isHidden = true
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .Assets.error
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            checkBoxButton,
            checkBoxLabel
        ])
        stackView.axis = .horizontal
        stackView.spacing = Constants.Layout.stackViewSpacing
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
        contentView.addSubview(errorLabel)
    }
    
    private func setUpLayoutConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.Layout.stackViewTopIndent
            ),
            stackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.Layout.stackViewHorizontalIndent
            ),
            stackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.Layout.stackViewHorizontalIndent
            ),
            errorLabel.topAnchor.constraint(
                equalTo: stackView.bottomAnchor,
                constant: Constants.Layout.mainSpacing
            ),
            errorLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.Layout.stackViewHorizontalIndent
            ),
            errorLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.Layout.stackViewHorizontalIndent
            ),
            errorLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Constants.Layout.errorLabelTopIndent
            ),
            checkBoxButton.widthAnchor.constraint(equalToConstant: Constants.Layout.checkBoxSize)
        ])
    }
    
    @objc private func touchUpInsideButton() {
        delegate?.updateCheckBoxSelection(checkBoxButton.isChecked)
    }
}

extension CheckBoxTableViewCell: CheckBoxValidationStatusDelegate {
    func setCheckBoxSelection(_ isSelected: Bool) {
        errorLabel.isHidden = isSelected
    }
}

