//
//  CustomTextField.swift
//  GeoNews
//
//  Created by M1 on 30.06.2024.
//

import UIKit

class CustomTextField: UITextField {
    enum CustomTextFieldType {
        case username
        case email
        case password
    }
    
    private let authFieldType: CustomTextFieldType
    
    init(fieldType: CustomTextFieldType) {
        self.authFieldType = fieldType
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor(red: 248/255, green: 249/255, blue: 250/255, alpha: 1)
        self.layer.cornerRadius = 10
        
        self.textColor = .black
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.font = UIFont(name: "FiraGO-Regular", size: 16)
        
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        switch fieldType {
        case .username:
            self.placeholder = "Username"
        case .email:
            self.placeholder = "Email Address"
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
            
        case .password:
            self.placeholder = "Password"
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
        }
        setPlaceholderTextColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setPlaceholderTextColor() {
        let placeholderText = self.placeholder ?? ""
        let color = UIColor(.gray)
        self.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: color,
                         NSAttributedString.Key.font: UIFont(name: "FiraGO-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)]
        )
    }
}
