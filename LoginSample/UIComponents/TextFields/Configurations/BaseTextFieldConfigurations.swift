//
//  BaseTextFieldConfigurations.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 28.06.2022.
//

import UIKit

struct DefaultBaseTextFieldConfiguration: BaseTextFieldConfigurable {
    let activeColor = UIColor.Assets.primary01
    let disableColor = UIColor.Assets.neutral02
    let errorColor = UIColor.Assets.error
    let eyeButtonActiveColor = UIColor.Assets.text
    let eyeButtonDisableColor = UIColor.Assets.neutral02
    let activePlaceholderFont = UIFont.preferredFont(forTextStyle: .caption1)
    let disablePlaceholderFront = UIFont.preferredFont(forTextStyle: .body)
    let helperTextFont = UIFont.preferredFont(forTextStyle: .caption1)
}
