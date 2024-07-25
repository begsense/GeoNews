//
//  ForgotPasswordViewModel.swift
//  GeoNews
//
//  Created by M1 on 08.07.2024.
//

import Foundation

class ForgotPasswordViewModel {
    var email: String = ""
    
    var didFailResetPassword: ((Error) -> Void)?
    var didResetPassword: (() -> Void)?
    
    func resetPasswordHandler() {
        resetPassword()
    }
    
    private func validateEmail() -> Bool {
        guard Validator.isValidEmail(for: email) else {
            let error = NSError(domain: "Validation", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid email format"])
            didFailResetPassword?(error)
            return false
        }
        return true
    }
    
    private func resetPassword() {
        guard validateEmail() else { return }
        AuthService.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.didFailResetPassword?(error)
            } else {
                self.didResetPassword?()
            }
        }
    }
}
