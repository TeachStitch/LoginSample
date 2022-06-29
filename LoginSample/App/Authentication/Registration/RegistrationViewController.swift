//
//  RegistrationViewController.swift
//  LoginSample
//
//  Created by Arsenii Kovalenko on 29.06.2022.
//

import UIKit

protocol CheckBoxValidationStatusDelegate: AnyObject {
    func setCheckBoxSelection(_ isSelected: Bool)
}

protocol FormValidationStatusDelegate: AnyObject {
    func setFullNameValid(_ isValid: Bool, reason: String?)
    func setEmailValid(_ isValid: Bool, reason: String?)
    func setPasswordValid(_ isValid: Bool, reason: String?)
}

protocol ButtonEnabledDelegate: AnyObject {
    var isButtonEnabled: Bool { get set }
}

class RegistrationViewController: UIViewController {
    
    private enum CellType: Int, CaseIterable {
        case header
        case form
        case checkBox
        case button
    }
    
    weak var formDelegate: FormValidationStatusDelegate?
    weak var checkBoxDelegate: CheckBoxValidationStatusDelegate?
    weak var buttonDelegate: ButtonEnabledDelegate?
    
    private let viewModel: RegistrationViewModelProvider
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .Assets.background
        tableView.register([
            HeaderTableViewCell.self,
            FormTableViewCell.self,
            CheckBoxTableViewCell.self,
            ButtonTableViewCell.self
        ])
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    init(viewModel: RegistrationViewModelProvider) {
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onLoad()
    }
    
    private func setUpSubviewvs() {
        view.addSubview(tableView)
    }
    
    private func setUpAutoLayoutConstraints() {
        tableView.pin(toEdges: view)
    }
}

extension RegistrationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch CellType(rawValue: indexPath.row) {
        case .header:
            guard let cell: HeaderTableViewCell = tableView.dequeueReusableCell(for: indexPath) else { return UITableViewCell() }
            
            return cell
        case .form:
            guard let cell: FormTableViewCell = tableView.dequeueReusableCell(for: indexPath) else { return UITableViewCell() }
            cell.delegate = self
            self.formDelegate = cell
            
            return cell
        case .checkBox:
            guard let cell: CheckBoxTableViewCell = tableView.dequeueReusableCell(for: indexPath) else { return UITableViewCell() }
            cell.delegate = self
            self.checkBoxDelegate = cell
            
            return cell
        case .button:
            guard let cell: ButtonTableViewCell = tableView.dequeueReusableCell(for: indexPath) else { return UITableViewCell() }
            cell.delegate = self
            self.buttonDelegate = cell
            
            return cell
        case .none:
            return UITableViewCell()
        }
    }
}

extension RegistrationViewController: RegistrationViewModelDelegate {
    func setRegistrationEnabled(_ isEnabled: Bool) {
        buttonDelegate?.isButtonEnabled = isEnabled
    }
    
    func setFullNameTextValidation(_ isValid: Bool, reason: String?) {
        formDelegate?.setFullNameValid(isValid, reason: reason)
    }
    
    func setEmailTextValidation(_ isValid: Bool, reason: String?) {
        formDelegate?.setEmailValid(isValid, reason: reason)
    }
    
    func setPasswordTextValidation(_ isValid: Bool, reason: String?) {
        formDelegate?.setPasswordValid(isValid, reason: reason)
    }
    
    func setCheckBoxSelection(_ isSelected: Bool) {
        checkBoxDelegate?.setCheckBoxSelection(isSelected)
    }
}

extension RegistrationViewController: FormTableViewCellDelegate {
    func getFullNameText(text: String) {
        viewModel.updateFullNameText(text)
    }
    
    func getUsernameText(text: String) {
        viewModel.updateEmailText(text)
    }
    
    func getPasswordText(text: String) {
        viewModel.updatePasswordText(text)
        tableView.reconfigureRows(at: [IndexPath(row: 1, section: 0)])
    }
}

extension RegistrationViewController: ButtonTableViewCellDelegate {
    func registrationButtonTapped() {
        viewModel.registrationTapped()
    }
    
    func loginButtonTapped() {
        viewModel.loginTapped()
    }
}

extension RegistrationViewController: CheckBoxTableViewCellDelegate {
    func updateCheckBoxSelection(_ isSelected: Bool) {
        viewModel.updateCheckBoxSelection(isSelected)
    }
}
