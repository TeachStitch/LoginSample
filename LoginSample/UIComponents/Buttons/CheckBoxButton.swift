//
//  CheckBoxButton.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import UIKit

class CheckBoxButton: UIButton {
    var isChecked: Bool = false {
        didSet {
            let newImage = isChecked ? UIImage.Assets.checkboxSelected : UIImage.Assets.checkboxActive
            setImage(newImage, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage.Assets.checkboxActive, for: .normal)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setImage(UIImage.Assets.checkboxActive, for: .normal)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        isChecked.toggle()
    }
}

