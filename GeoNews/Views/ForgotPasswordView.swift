//
//  ForgotPasswordView.swift
//  GeoNews
//
//  Created by M1 on 28.06.2024.
//

import UIKit
import SwiftUI

class ForgotPasswordView: UIViewController {
    
    // MARK: - Properties
    private let header = UIHostingController(rootView: AuthHeaderView(title: "Forgot Password", description: "Reset your password"))
    private let emailField = CustomTextField(fieldType: .email)
    private let resetPasswordButton = CustomButton(title: "Reset Password", hasBackground: true, fontSize: .big)
    
    private var viewModel = ForgotPasswordViewModel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        setupViewModelCallbacks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor(red: 47/255, green: 56/255, blue: 71/255, alpha: 1)
        
        addChild(header)
        view.addSubview(header.view)
        header.view.translatesAutoresizingMaskIntoConstraints = false
        header.view.backgroundColor = UIColor(red: 47/255, green: 56/255, blue: 71/255, alpha: 1)
        NSLayoutConstraint.activate([
            header.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            header.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.view.heightAnchor.constraint(equalToConstant: 230)
        ])
        
        view.addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: header.view.bottomAnchor, constant: 11),
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 55),
            emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])
        
        view.addSubview(resetPasswordButton)
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetPasswordButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22),
            resetPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 55),
            resetPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])
    }
    
    // MARK: - Actions
    private func setupActions() {
        resetPasswordButton.addTarget(self, action: #selector(didTapResetPassword), for: .touchUpInside)
        
        emailField.addAction(UIAction { [weak self] _ in
            self?.viewModel.email = self?.emailField.text ?? ""
        }, for: .editingChanged)
    }
    
    @objc private func didTapResetPassword() {
        viewModel.resetPassword()
    }
    
    // MARK: - ViewModel Callbacks
    private func setupViewModelCallbacks() {
        viewModel.didResetPassword = { [weak self] in
            self?.showPasswordResetAlert()
        }
        
        viewModel.didFailResetPassword = { [weak self] error in
            guard let self = self else { return }
            
       
                let errorMessage = (error as NSError).localizedDescription
                switch errorMessage {
                case "Invalid email format":
                    AlertManager.showInvalidEmailAlert(on: self)
                default:
                    AlertManager.showErrorSendingPasswordReset(on: self, with: error)
                }
            
        }
    }
    
    // MARK: - Alert
    private func showPasswordResetAlert() {
        AlertManager.showPasswordResetSent(on: self)
    }
}
