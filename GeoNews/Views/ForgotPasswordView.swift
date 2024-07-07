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
    
    private let resetPasswordButton = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .big)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
      //  self.resetPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(header.view)
        self.view.addSubview(emailField)
        self.view.addSubview(resetPasswordButton)
        
        header.view.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            header.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            header.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.view.heightAnchor.constraint(equalToConstant: 230),
            
            emailField.topAnchor.constraint(equalTo:  header.view.bottomAnchor, constant: 11),
            emailField.centerXAnchor.constraint(equalTo:  header.view.centerXAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 55),
            emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            
            resetPasswordButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22),
            resetPasswordButton.centerXAnchor.constraint(equalTo:  header.view.centerXAnchor),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 55),
            resetPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
        ])
    }
    

}
