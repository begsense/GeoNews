//
//  SignInView.swift
//  GeoNews
//
//  Created by M1 on 27.06.2024.
//

import UIKit
import SwiftUI

class SignInView: UIViewController {
    
    // MARK: - Properties
    private var header = UIHostingController(rootView: AuthHeaderView(title: "Sign In", description: "Sign in to your account"))
    
    private var emailField = CustomTextField(fieldType: .email)
    private var passwordField = CustomTextField(fieldType: .password)
    
    private var signInButton = CustomButton(title: "Sign In", hasBackground: true, fontSize: .big)
    private var newUserButton = CustomButton(title: "New User? Create Account.", fontSize: .med)
    private var forgotPasswordButton = CustomButton(title: "Forgot Password?", fontSize: .small)
    
    private var viewModel = SignInViewModel()
    
    private let loader = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor(red: 47/255, green: 56/255, blue: 71/255, alpha: 1)
        setupHeader()
        setupEmailField()
        setupPasswordField()
        setupSignInButton()
        setupNewUserButton()
        setupForgotPasswordButton()
        setupLoader()
        setupActions()
    }
    
    private func setupHeader() {
        view.addSubview(header.view)
        header.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            header.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.view.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        header.view.backgroundColor = UIColor(red: 47/255, green: 56/255, blue: 71/255, alpha: 1)
    }
    
    private func setupEmailField() {
        view.addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: header.view.bottomAnchor, constant: 20),
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            emailField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupPasswordField() {
        view.addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            passwordField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupSignInButton() {
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            signInButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupNewUserButton() {
        view.addSubview(newUserButton)
        newUserButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newUserButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            newUserButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newUserButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])
    }
    
    private func setupForgotPasswordButton() {
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: newUserButton.bottomAnchor),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgotPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])
    }
    
    private func setupLoader() {
        view.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        loader.color = UIColor(red: 231/255, green: 161/255, blue: 21/255, alpha: 1)
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Actions
    private func setupActions() {
        signInButton.addAction(UIAction { [weak self] _ in
            self?.startLoading()
            self?.viewModel.signIn()
        }, for: .touchUpInside)
        
        newUserButton.addAction(UIAction { [weak self] _ in
            self?.didTapNewUser()
        }, for: .touchUpInside)
        
        forgotPasswordButton.addAction(UIAction { [weak self] _ in
            self?.didTapForgotPassword()
        }, for: .touchUpInside)
        
        emailField.addAction(UIAction { [weak self] _ in
            self?.viewModel.email = self?.emailField.text ?? ""
        }, for: .editingChanged)
        
        passwordField.addAction(UIAction { [weak self] _ in
            self?.viewModel.password = self?.passwordField.text ?? ""
        }, for: .editingChanged)
    }
    
    // MARK: - ViewModel Binding
    private func bindViewModel() {
        viewModel.didSignIn = { [weak self] in
            DispatchQueue.main.async {
                self?.stopLoading()
                if let sceneDelegate = self?.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            }
        }
        
        viewModel.didFailSignIn = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.stopLoading()
                guard let errorMessage = errorMessage else { return }
                switch errorMessage {
                case "Invalid email format":
                    AlertManager.showInvalidEmailAlert(on: self!)
                case "Invalid password format":
                    AlertManager.showInvalidPasswordAlert(on: self!)
                default:
                    let error = NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    AlertManager.showSignInErrorAlert(on: self!, with: error)
                }
            }
        }
    }
    
    // MARK: - Navigation
    private func didTapNewUser() {
        let vc = SignUpView()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func didTapForgotPassword() {
        let vc = ForgotPasswordView()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Loading Indicator
    private func startLoading() {
        loader.startAnimating()
    }
    
    private func stopLoading() {
        loader.stopAnimating()
    }
}
