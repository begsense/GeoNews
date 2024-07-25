//
//  AuthHeaderView.swift
//  GeoNews
//
//  Created by M1 on 28.06.2024.
//

import UIKit

class AuthHeaderView: UIView {
    //MARK: - Properties
    private var logoImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.contentMode = .scaleAspectFit
        logoImage.image = UIImage(named: "logo")
        return logoImage
    }()
    
    private var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "FiraGO-Regular", size: 26)
        label.text = "Error"
        return label
    }()
    
    private var subTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "FiraGO-Regular", size: 18)
        label.text = "Error"
        return label
    }()
    
    //MARK: - LifeCycle
    init(titleText: String, subTitleText: String) {
        super.init(frame: .zero)
        title.text = titleText
        subTitle.text = subTitleText
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - UI Setup
    private func setupUI() {
        addSubview(logoImage)
        addSubview(title)
        addSubview(subTitle)
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 110),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor),
            
            title.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            subTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            subTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
