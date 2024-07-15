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
    private let header = AuthHeaderView(title: "Forgot Password", subTitle: "Reset your password")
    private let emailField = CustomTextField(fieldType: .email)
    private let resetPasswordButton = CustomButton(title: "Reset", hasBackground: true, fontSize: .big)
    
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
        let gradientLayer = GradientLayer(bounds: view.bounds)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        setupHeader()
        setupEmailField()
        setupResetPasswordButton()
    }
    
    private func setupHeader() {
        view.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.heightAnchor.constraint(equalToConstant: 210)
        ])
    }
    
    private func setupEmailField() {
        view.addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            emailField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupResetPasswordButton() {
        view.addSubview(resetPasswordButton)
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetPasswordButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            resetPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
            //resetPasswordButton.heightAnchor.constraint(equalToConstant: 40)
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
            guard let self = self else { return }
            AlertManager.showPasswordResetSent(on: self)
        }
        
        viewModel.didFailResetPassword = { [weak self] error in
            guard let self = self else { return }
            
            let errorMessage = (error as NSError).localizedDescription
            switch errorMessage {
            case "Invalid email format":
                AlertManager.showInvalidEmailAlert(on: self)
            default:
                AlertManager.showErrorSendingPasswordReset(on: self)
            }
            
        }
    }
}
