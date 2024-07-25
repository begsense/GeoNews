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
        setTitle(title, for: .normal)
        layer.cornerRadius = 12
        layer.masksToBounds = true
        
        backgroundColor = hasBackground ? UIColor(red: 4/255, green: 123/255, blue: 128/255, alpha: 1) : .clear
        
        setTitleColor(.white, for: .normal)
        
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
