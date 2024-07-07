//
//  SignInViewModel.swift
//  GeoNews
//
//  Created by M1 on 07.07.2024.
//

import Foundation

class SignInViewModel {
    var email: String = ""
    var password: String = ""
    var errorMessage: String? {
        didSet {
            showErrorMessage?(errorMessage)
        }
    }
    var isValid: Bool = false
    var showErrorMessage: ((String?) -> Void)?

    func validateForm() -> Bool {
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
    
    func signIn(completion: @escaping (String?) -> Void) {
        if validateForm() {
            let loginRequest = LoginUserRequest(email: email, password: password)
            AuthService.shared.signIn(with: loginRequest) { error in
                if let error = error {
                    completion(error.localizedDescription)
                } else {
                    completion(nil)
                }
            }
        } else {
            completion(errorMessage)
        }
    }
}
