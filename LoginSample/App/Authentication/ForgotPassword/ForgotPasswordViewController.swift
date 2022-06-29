//
//  ForgotPasswordViewController.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    private let viewModel: ForgotPasswordViewModelProvider
    
    init(viewModel: ForgotPasswordViewModelProvider) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviewvs()
        setUpAutoLayoutConstraints()
        viewModel.onLoad()
    }
    
    private func setUpSubviewvs() {
        view.backgroundColor = .green
    }
    
    private func setUpAutoLayoutConstraints() {
        
    }
}

extension ForgotPasswordViewController: ForgotPasswordViewModelDelegate {
    
}
