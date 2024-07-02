//
//  SignInView.swift
//  GeoNews
//
//  Created by M1 on 27.06.2024.
//

import UIKit
import SwiftUI

class SignInView: UIViewController {
    
    //MARK: - Properties
    private var header = UIHostingController(rootView: AuthHeaderView(title: "Sign In", description: "Sign in to your account"))
    
    private var usernameField = CustomTextField(fieldType: .username)
    private var passwordField = CustomTextField(fieldType: .password)
    
    private var signInButton = CustomButton(title: "Sign In", hasBackground: true, fontSize: .big)
    private var newUserButton = CustomButton(title: "New User? Create Account.", fontSize: .med)
    private var forgotPasswordButton = CustomButton(title: "Forgot Password?", fontSize: .small)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 47/255, green: 56/255, blue: 71/255, alpha: 1)
        setupHeader()
        setupUsernameField()
        setupPasswordField()
        setupSignInButton()
        setupNewUserButton()
        setupForgotPasswordButton()
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
    
    private func setupUsernameField() {
        view.addSubview(usernameField)
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: header.view.bottomAnchor, constant: 20),
            usernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            usernameField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupPasswordField() {
        view.addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20),
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
    
    // MARK: - Actions
    private func setupActions() {
        signInButton.addAction(UIAction { [weak self] _ in
            self?.didTapSignIn()
        }, for: .touchUpInside)
        
        newUserButton.addAction(UIAction { [weak self] _ in
            self?.didTapNewUser()
        }, for: .touchUpInside)
        
        forgotPasswordButton.addAction(UIAction { [weak self] _ in
            self?.didTapForgotPassword()
        }, for: .touchUpInside)
    }
    
    private func didTapSignIn() {
        let vc = RootViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: false, completion: nil)
    }
    
    private func didTapNewUser() {
        let vc = SignUpView()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func didTapForgotPassword() {
        let vc = ForgotPasswordView()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

