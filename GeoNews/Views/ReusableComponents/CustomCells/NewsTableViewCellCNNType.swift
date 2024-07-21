//
//  NewsTableViewCellCNNType.swift
//  GeoNews
//
//  Created by M1 on 21.07.2024.
//

import UIKit

class NewsTableViewCellCNNType: UITableViewCell {
    //MARK: Properties:
    static var identifier: String {
        String(describing: self)
    }
    
    private var newsImage: UIImageView = {
        let newsImage = UIImageView()
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsImage.contentMode = .scaleAspectFill
        newsImage.clipsToBounds = true
        newsImage.layer.cornerRadius = 15
        newsImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return newsImage
    }()
    
    private var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.8).cgColor]
        gradient.locations = [0.0, 1.0]
        return gradient
    }()
    
    private var tvTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 16)
        label.textColor = .white
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return label
    }()
    
    private var newsHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 15)
        label.textColor = .white
        label.numberOfLines = 0
        label.heightAnchor.constraint(equalToConstant: 85).isActive = true
        return label
    }()
    
    private var newsDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 12)
        label.textColor = .white
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return label
    }()
    
    //MARK: Lifecycle:
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = newsImage.bounds
    }
    
    //MARK: SetupUI:
    func setupUI() {
        contentView.backgroundColor = .clear
        
        setupNewsImage()
        setupNewsDetails()
    }
    
    private func setupNewsImage() {
        contentView.addSubview(newsImage)
        
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            newsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        newsImage.layer.addSublayer(gradientLayer)
    }
    
    private func setupNewsDetails() {
        newsImage.addSubview(tvTitle)
        newsImage.addSubview(newsHeader)
        newsImage.addSubview(newsDate)
        
        NSLayoutConstraint.activate([
            tvTitle.topAnchor.constraint(equalTo: newsImage.topAnchor, constant: 75),
            tvTitle.leadingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: 10),
            
            newsHeader.topAnchor.constraint(equalTo: tvTitle.bottomAnchor),
            newsHeader.leadingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: 10),
            newsHeader.trailingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: -10),
            
            newsDate.topAnchor.constraint(equalTo: newsHeader.bottomAnchor),
            newsDate.leadingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: 10)
        ])
    }
}


extension NewsTableViewCellCNNType: ConfigurableNewsCell {
    func configure(with news: News) {
        tvTitle.text = news.name
        newsDate.text = news.date
        newsHeader.text = news.title
        newsImage.setImage(with: news.image)
    }
}

