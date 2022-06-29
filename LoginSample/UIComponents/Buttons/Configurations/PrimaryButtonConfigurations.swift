//
//  PrimaryButtonConfigurations.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import UIKit

struct DefaultPrimaryButtonConfiguration: BaseButtonConfigurable {
    let defaultBackgroundColor = UIColor.Assets.accent
    let activeBackgroundColor = UIColor.Assets.accentActive
    let disabledBackgroundColor = UIColor.Assets.neutral02
    let defaultTextColor = UIColor.Assets.text
    let disabledTextColor = UIColor.Assets.neutral01
    let textFont = UIFont.preferredFont(forTextStyle: .title2)
}

struct SecondaryPrimaryButtonConfiguration: BaseButtonConfigurable {
    let disabledBackgroundColor = UIColor.clear
    let defaultBackgroundColor = UIColor.clear
    let activeBackgroundColor = UIColor.Assets.primary03
    let defaultTextColor = UIColor.Assets.primary01
    let disabledTextColor = UIColor.Assets.neutral02
    let textFont = UIFont.preferredFont(forTextStyle: .caption1)
}
