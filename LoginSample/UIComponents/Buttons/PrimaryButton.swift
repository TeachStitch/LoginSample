//
//  PrimaryButton.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import UIKit

class PrimaryButton: BaseButton {

    private enum Constants {
        static let cornerRadius = 5.0
    }

    override init(with setting: BaseButtonConfigurable = DefaultPrimaryButtonConfiguration()) {
        super.init(with: setting)
        backgroundColor = setting.defaultBackgroundColor
        layer.cornerRadius = Constants.cornerRadius
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

