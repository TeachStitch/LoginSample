//
//  HeaderTableViewCell.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let greetingText = "Hello"
        static let ctaText = "Please register to start using the app"
        
        enum Layout {
            static let mainStackViewSpacing = 8.0
            static let greetingsLabelHeight = 26.0
            static let ctaLabelHeight = 17.0
        }
    }
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.greetingText
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textColor = .Assets.primary01
        
        return label
    }()
    
    private lazy var ctaLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.ctaText
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .Assets.text
        
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Constants.Layout.mainStackViewSpacing
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.addArrangedSubview(greetingLabel)
        stackView.addArrangedSubview(ctaLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubviews()
        setUpAutoLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpSubviews() {
        contentView.addSubview(mainStackView)
    }
    
    private func setUpAutoLayoutConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            greetingLabel.heightAnchor.constraint(equalToConstant: Constants.Layout.greetingsLabelHeight),
            ctaLabel.heightAnchor.constraint(equalToConstant: Constants.Layout.ctaLabelHeight)
        ])
    }
}

