//
//  SavedNewsCell.swift
//  GeoNews
//
//  Created by M1 on 20.07.2024.
//

import UIKit

class SavedNewsCell: UICollectionViewCell {
    
    //MARK: Properties:
    static var identifier: String {
        String(describing: self)
    }
    
    private var savedNewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.heightAnchor.constraint(equalToConstant: 105).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var savedNewsTitle: UILabel = {
       let label = UILabel()
        label.text = "Sorry error displaying title"
        label.font = UIFont(name: "FiraGO-Regular", size: 8)
        label.textColor = .white
        label.numberOfLines = 0
        label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: SetupUI:
    
    func setupUI() {
        contentView.addSubview(savedNewsImage)
        contentView.addSubview(savedNewsTitle)
        NSLayoutConstraint.activate([
            savedNewsImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            savedNewsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            savedNewsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            savedNewsTitle.topAnchor.constraint(equalTo: savedNewsImage.bottomAnchor, constant: 5),
            savedNewsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            savedNewsTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
}

extension SavedNewsCell: ConfigurableNewsCell {
    func configure(with news: News) {
        savedNewsImage.setImage(with: news.image)
        savedNewsTitle.text = news.title
    }
}
