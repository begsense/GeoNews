//
//  SignUpViewModel.swift
//  GeoNews
//
//  Created by M1 on 08.07.2024.
//

import Foundation

class SignUpViewModel {
    
    // MARK: - Properties
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var errorMessage: String?
    var isValid: Bool = false
    
    // MARK: - Callbacks
    var didSignUp: (() -> Void)?
    var didFailSignUp: ((String?) -> Void)?
    var didTapSignIn: (() -> Void)?
    
    // MARK: - Handling
    func handleSignUp() {
        signUp()
    }
    
    func handleSignInTap() {
        didTapSignIn?()
    }
    
    // MARK: - Private functions
    private func validateForm() -> Bool {
        if !Validator.isValidUsername(for: username) {
            errorMessage = "Invalid username format"
            isValid = false
        } else if !Validator.isValidEmail(for: email) {
            errorMessage = "Invalid email format"
            isValid = false
        } else if !Validator.isPasswordValid(for: password) {
            errorMessage = "Invalid password format"
            isValid = false
        } else {
            errorMessage = nil
            isValid = !username.isEmpty && !email.isEmpty && !password.isEmpty
        }
        return isValid
    }
    
    private func signUp() {
        if validateForm() {
            let registerRequest = RegisterUserRequest(username: username, email: email, password: password, score: 0)
            AuthService.shared.registerUser(with: registerRequest) { [weak self] success, error in
                guard let self = self else { return }
                if let error = error {
                    self.didFailSignUp?(error.localizedDescription)
                } else {
                    self.didSignUp?()
                }
            }
        } else {
            didFailSignUp?(errorMessage)
        }
    }
}
