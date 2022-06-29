//
//  UITableView+Extensions.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import UIKit

extension UITableView {
    
    final func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    final func register(_ cellTypes: [UITableViewCell.Type]) {
        cellTypes.forEach { register($0.self, forCellReuseIdentifier: $0.identifier) }
    }
    
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            assertionFailure(
                "Failed to dequeue a cell with identifier \(T.identifier) matching type \(T.self). Check that you registered the cell beforehand."
            )
            return nil
        }
        
        return cell
    }
}

