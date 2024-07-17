//
//  SignInViewModel.swift
//  GeoNews
//
//  Created by M1 on 07.07.2024.
//

import Foundation

class SignInViewModel {
    
    // MARK: - Properties
    var email: String = ""
    var password: String = ""
    var errorMessage: String?
    var isValid: Bool = false
    
    // MARK: - Callbacks
    var didSignIn: (() -> Void)?
    var didFailSignIn: ((String?) -> Void)?
    var didTapNewUser: (() -> Void)?
    var didTapForgotPassword: (() -> Void)?
    
    //MARK: - Handling
    func handleSignIn() {
        signIn()
    }
    
    func handleNewUserTap() {
        didTapNewUser?()
    }
    
    func handleForgotPasswordTap() {
        didTapForgotPassword?()
    }
    
    // MARK: - Private functions
    private func validateForm() -> Bool {
        if !Validator.isValidEmail(for: email) {
            errorMessage = "Invalid email format"
            isValid = false
        } else if !Validator.isPasswordValid(for: password) {
            errorMessage = "Invalid password format"
            isValid = false
        } else {
            errorMessage = nil
            isValid = !email.isEmpty && !password.isEmpty
        }
        return isValid
    }
    
    private func signIn() {
        if validateForm() {
            let loginRequest = LoginUserRequest(email: email, password: password)
            AuthService.shared.signIn(with: loginRequest) { [weak self] error in
                guard let self = self else { return }
                if let error = error {
                    self.didFailSignIn?(error.localizedDescription)
                } else {
                    self.didSignIn?()
                }
            }
        } else {
            didFailSignIn?(errorMessage)
        }
    }
}
