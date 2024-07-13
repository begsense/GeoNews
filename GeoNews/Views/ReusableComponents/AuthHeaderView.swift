//
//  AuthHeaderView.swift
//  GeoNews
//
//  Created by M1 on 28.06.2024.
//

import UIKit

class AuthHeaderView: UIView {
    
    // MARK: - UI Components
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "logo")
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "FiraGO-Regular", size: 26)
        label.text = "Error"
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "FiraGO-Regular", size: 18)
        label.text = "Error"
        return label
    }()
    
    // MARK: - LifeCycle
    init(title: String, subTitle: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        subTitleLabel.text = subTitle
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 110),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
