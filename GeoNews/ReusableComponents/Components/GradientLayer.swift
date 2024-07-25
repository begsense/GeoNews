//
//  GradientLayer.swift
//  GeoNews
//
//  Created by M1 on 13.07.2024.
//

import UIKit

public func GradientLayer(bounds: CGRect) -> CAGradientLayer {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = bounds
    gradientLayer.colors = [
        UIColor(red: 0/255, green: 64/255, blue: 99/255, alpha: 1).cgColor,
        UIColor(red: 0/255, green: 42/255, blue: 69/255, alpha: 1).cgColor
    ]
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
    return gradientLayer
}
