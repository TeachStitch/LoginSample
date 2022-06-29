//
//  BaseButton.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import UIKit

protocol BaseButtonConfigurable {
    var defaultBackgroundColor: UIColor { get }
    var activeBackgroundColor: UIColor { get }
    var disabledBackgroundColor: UIColor { get }
    var defaultTextColor: UIColor { get }
    var disabledTextColor: UIColor { get }
    var textFont: UIFont { get }
}

class BaseButton: UIButton {
    
    private let setting: BaseButtonConfigurable
        
    init(with setting: BaseButtonConfigurable) {
        self.setting = setting
        super.init(frame: .zero)
        titleLabel?.font = setting.textFont
        backgroundColor = setting.defaultBackgroundColor
        setTitleColor(setting.defaultTextColor, for: .normal)
        setTitleColor(setting.disabledTextColor, for: .disabled)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? setting.activeBackgroundColor : setting.defaultBackgroundColor
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? setting.defaultBackgroundColor : setting.disabledBackgroundColor
        }
    }
}

