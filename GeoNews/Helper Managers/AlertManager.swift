//
//  AlertManager.swift
//  GeoNews
//
//  Created by M1 on 07.07.2024.
//

import UIKit

class AlertManager {
    public static func showBasicAlert(on vc: UIViewController, title: String, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            vc.present(alert, animated: true)
        }
    }
}

// Validations
extension AlertManager {
    public static func showInvalidEmailAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "არასწორი ელ-ფოსტა", message: "ელფოსტის ფორმატი არასწორია")
    }
    
    public static func showInvalidPasswordAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "არასწორი პაროლი", message: "პაროლის ფორმატი არასწორია. გამოიყენეთ მინიმუმ 8 სიმბოლო, რომელიც შეიცავს (Aa1!) სიმბოლოებს")
    }
    
    public static func showInvalidUsernameAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "არასწორი Username", message: "Username ფორმატი არასწორია. გთხოვთ შეიყვანეთ Min 4, Max 12 სიმბოლო")
    }
}

// Register
extension AlertManager {
    public static func showRegistrationErrorAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "ვერ მოხდა რეგისტრაცია", message: "დაფიქსირდა შეცდომა, გთხოვთ სცადოთ ხელახლა")
    }
}

// Authorization
extension AlertManager {
    public static func showSignInErrorAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "ვერ მოხდა ავტორიზაცია", message: "პაროლი არასწორია ან ხარვეზია ბაზაში. გთხოვთ სცადოთ ხელახლა")
    }
}

// Logout
extension AlertManager {
    public static func showLogoutError(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "სისტემიდან გასვლა ვერ მოხდა", message: "დაფიქსირდა შეცდომა, გთხოვთ სცადოთ ხელახლა")
    }
}

// Forgot Password
extension AlertManager {
    public static func showPasswordResetSent(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "პაროლი გამოიგზავნა", message: "პაროლი ელ-ფოსტაზე განსაახლებლად გამოგზავნილია")
    }
    
    public static func showErrorSendingPasswordReset(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "ახალი პაროლი ვერ გამოიგზავნა", message: "დაფიქსირდა შეცდომა, გთხოვთ სცადოთ ხელახლა")
    }
}

// Fetching Erros
extension AlertManager {
    public static func fetchingUserError(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "მონაცემები ვერ მოიქაჩა", message: "ბაზიდან მონაცემების წამოღებისას დაფიქსირდა შეცდომა, გთხოვთ მოგვიანებით სცადოთ")
    }
}
