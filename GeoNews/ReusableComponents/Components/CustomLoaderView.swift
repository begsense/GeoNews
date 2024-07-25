//
//  CustomLoaderView.swift
//  GeoNews
//
//  Created by M1 on 08.07.2024.
//

import UIKit

class CustomLoaderView: UIView {
    
    private let shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLoader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLoader()
    }
    
    private func setupLoader() {
        let airplanePath = UIBezierPath()
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let size: CGFloat = 30
        
        airplanePath.move(to: CGPoint(x: center.x, y: center.y - size / 2))
        airplanePath.addLine(to: CGPoint(x: center.x - size / 4, y: center.y + size / 7))
        airplanePath.addLine(to: CGPoint(x: center.x, y: center.y))
        airplanePath.addLine(to: CGPoint(x: center.x + size / 4, y: center.y + size / 7))
        airplanePath.close()
        
        shapeLayer.path = airplanePath.cgPath
        shapeLayer.strokeColor = UIColor(red: 138/255, green: 255/255, blue: 99/255, alpha: 1).cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.fillColor = UIColor(red: 0/255, green: 42/255, blue: 69/255, alpha: 1).cgColor
        shapeLayer.lineCap = .round
        shapeLayer.lineJoin = .round
        
        layer.addSublayer(shapeLayer)
    }
    
    func startAnimating() {
        isHidden = false
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = 2 * CGFloat.pi
        rotationAnimation.duration = 1
        rotationAnimation.repeatCount = .infinity
        shapeLayer.add(rotationAnimation, forKey: "rotate")
    }
    
    func stopAnimating() {
        shapeLayer.removeAllAnimations()
        isHidden = true
    }
}
