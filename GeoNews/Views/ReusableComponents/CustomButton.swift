//
//  CustomButton.swift
//  GeoNews
//
//  Created by M1 on 01.07.2024.
//

import UIKit

class CustomButton: UIButton {
    
    enum FontSize {
        case big
        case med
        case small
    }
    
    init(title: String, hasBackground: Bool = false, fontSize: FontSize) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        self.backgroundColor = hasBackground ? UIColor(red: 231/255, green: 161/255, blue: 21/255, alpha: 1) : .clear
        
        let titleColor: UIColor = hasBackground ? UIColor.white : UIColor(red: 231/255, green: 161/255, blue: 21/255, alpha: 1)
        self.setTitleColor(titleColor, for: .normal)
        
        switch fontSize {
        case .big:
            self.titleLabel?.font = UIFont(name: "FiraGO-Regular", size: 22)
            
        case .med:
            self.titleLabel?.font = UIFont(name: "FiraGO-Regular", size: 18)
            
        case .small:
            self.titleLabel?.font = UIFont(name: "FiraGO-Regular", size: 16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
