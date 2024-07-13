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
        let arrowPath = UIBezierPath()
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius: CGFloat = 22
        let arrowSize: CGFloat = 11
        
        arrowPath.move(to: CGPoint(x: center.x + radius, y: center.y))
        arrowPath.addLine(to: CGPoint(x: center.x + radius - arrowSize, y: center.y - arrowSize))
        arrowPath.addLine(to: CGPoint(x: center.x + radius - arrowSize, y: center.y + arrowSize))
        arrowPath.close()
        shapeLayer.path = arrowPath.cgPath
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
