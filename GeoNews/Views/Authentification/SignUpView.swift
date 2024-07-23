//
//  SignUpView.swift
//  GeoNews
//
//  Created by M1 on 28.06.2024.
//

import UIKit
import SwiftUI

class SignUpView: UIViewController {
    //MARK: - Properties
    private var header = AuthHeaderView(title: "Sign Up", subTitle: "Create your account")
    
    private var usernameField = CustomTextField(fieldType: .username)
    
    private var emailField = CustomTextField(fieldType: .email)
    
    private var passwordField = CustomTextField(fieldType: .password)
    
    private var signUpButton = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .big)
    
    private var signInButton = CustomButton(title: "Already have an account? Sign In", fontSize: .med)
    
    private var loaderView = CustomLoaderView()
    
    private var termsTextView: UITextView = {
        let attributedString = NSMutableAttributedString(string: "By creating an account, you agree to our Terms & Conditions and you acknowledge that you have read our Privacy Policy.")
        
        attributedString.addAttribute(.link, value: "terms://termsAndConditions", range: (attributedString.string as NSString).range(of: "Terms & Conditions"))
        attributedString.addAttribute(.link, value: "privacy://privacyPolicy", range: (attributedString.string as NSString).range(of: "Privacy Policy"))
        
        let tv = UITextView()
        tv.linkTextAttributes = [.foregroundColor: UIColor(red: 4/255, green: 123/255, blue: 128/255, alpha: 1)]
        tv.backgroundColor = .clear
        tv.attributedText = attributedString
        tv.textColor = UIColor(white: 1, alpha: 1)
        tv.isSelectable = true
        tv.isEditable = false
        tv.delaysContentTouches = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    private var viewModel: SignUpViewModel
    
    //MARK: - LifeCycle
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        let gradientLayer = GradientLayer(bounds: view.bounds)
        view.layer.insertSublayer(gradientLayer, at: 0)
        setupHeader()
        setupUsernameField()
        setupEmailField()
        setupPasswordField()
        setupSignUpButton()
        setupTermsTextView()
        setupSignInButton()
        setupActions()
        setupLoader()
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
    
    private func setupUsernameField() {
        view.addSubview(usernameField)
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            usernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            usernameField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupEmailField() {
        view.addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20),
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
    
    private func setupSignUpButton() {
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            signUpButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTermsTextView() {
        view.addSubview(termsTextView)
        termsTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            termsTextView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 20),
            termsTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            termsTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])
        termsTextView.delegate = self
    }
    
    private func setupSignInButton() {
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: termsTextView.bottomAnchor, constant: 20),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])
    }
    
    private func setupLoader() {
        view.addSubview(loaderView)
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.isHidden = true
        
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    //MARK: - Actions
    private func setupActions() {
        signUpButton.addAction(UIAction { [weak self] _ in
            self?.startLoading()
            self?.viewModel.handleSignUp()
        }, for: .touchUpInside)
        
        signInButton.addAction(UIAction { [weak self] _ in
            self?.viewModel.handleSignInTap()
        }, for: .touchUpInside)
        
        usernameField.addAction(UIAction { [weak self] _ in
            self?.viewModel.username = self?.usernameField.text ?? ""
        }, for: .editingChanged)
        
        emailField.addAction(UIAction { [weak self] _ in
            self?.viewModel.email = self?.emailField.text ?? ""
        }, for: .editingChanged)
        
        passwordField.addAction(UIAction { [weak self] _ in
            self?.viewModel.password = self?.passwordField.text ?? ""
        }, for: .editingChanged)
    }
    
    //MARK: - ViewModel Binding
    private func bindViewModel() {
        viewModel.didSignUp = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.stopLoading()
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            }
        }
        
        viewModel.didFailSignUp = { [weak self] errorMessage in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.stopLoading()
                if let errorMessage = errorMessage {
                    switch errorMessage {
                    case "Invalid username format":
                        AlertManager.showInvalidUsernameAlert(on: self)
                    case "Invalid email format":
                        AlertManager.showInvalidEmailAlert(on: self)
                    case "Invalid password format":
                        AlertManager.showInvalidPasswordAlert(on: self)
                    default:
                        AlertManager.showRegistrationErrorAlert(on: self)
                    }
                }
            }
        }
        
        viewModel.didTapSignIn = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - Loader
    private func startLoading() {
        loaderView.startAnimating()
    }
    
    private func stopLoading() {
        loaderView.stopAnimating()
    }
}

extension SignUpView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        handleURLInteraction(URL)
        return false
    }
    
    private func handleURLInteraction(_ URL: URL) {
        if URL.scheme == "terms" {
            showWebViewerController(with: "https://policies.google.com/terms?hl=en")
        } else if URL.scheme == "privacy" {
            showWebViewerController(with: "https://policies.google.com/privacy?hl=en")
        }
    }
    
    private func showWebViewerController(with urlString: String) {
        let vc = WebViewer(with: urlString)
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
}
