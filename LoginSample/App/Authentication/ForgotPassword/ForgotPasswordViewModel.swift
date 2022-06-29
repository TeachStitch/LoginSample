//
//  ForgotPasswordViewModel.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import Foundation

protocol ForgotPasswordViewModelProvider: AnyObject {
    func onLoad()
}

protocol ForgotPasswordViewModelDelegate: AnyObject {
    
}

class ForgotPasswordViewModel: ForgotPasswordViewModelProvider {
    
    typealias PathAction = (ForgotPasswordCoordinator.Path) -> Void
    
    weak var delegate: ForgotPasswordViewModelDelegate?
    
    private let model: ForgotPasswordModelProvider
    private let pathAction: PathAction
    
    init(model: ForgotPasswordModelProvider, pathAction: @escaping PathAction) {
        self.model = model
        self.pathAction = pathAction
    }
    
    func onLoad() {
        print(#function)
    }
}
