//
//  UIVIew+Extensions.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import UIKit

extension UIView {
    func pin(toEdges view: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

