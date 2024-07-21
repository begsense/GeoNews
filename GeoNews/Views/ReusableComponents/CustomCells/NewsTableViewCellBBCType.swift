//
//  NewsTableViewCellBBCType.swift
//  GeoNews
//
//  Created by M1 on 21.07.2024.
//

import UIKit

class NewsTableViewCellBBCType: UITableViewCell {
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
        newsImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        return newsImage
    }()
    
    private var newsHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 15)
        label.textColor = .white
        label.numberOfLines = 0
        label.heightAnchor.constraint(equalToConstant: 130).isActive = true
        return label
    }()
    
    private var newsOwner: UIView = {
        let newsOwner = UIView()
        newsOwner.translatesAutoresizingMaskIntoConstraints = false
        newsOwner.heightAnchor.constraint(equalToConstant: 10).isActive = true
        return newsOwner
    }()
    
    private var newsDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 11)
        label.textColor = .white
        label.heightAnchor.constraint(equalToConstant: 13).isActive = true
        return label
    }()
    
    private var tvTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 11)
        label.textColor = .white
        label.heightAnchor.constraint(equalToConstant: 13).isActive = true
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
    
    //MARK: SetupUI:
    func setupUI() {
        contentView.backgroundColor = .clear
        
        setupNewsImage()
        setupNewsHeader()
        setupNewsOwner()
    }
    
    private func setupNewsImage() {
        contentView.addSubview(newsImage)
        
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            newsImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4)
        ])
    }
    
    private func setupNewsHeader() {
        contentView.addSubview(newsHeader)
        
        NSLayoutConstraint.activate([
            newsHeader.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsHeader.leadingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: 10),
            newsHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupNewsOwner() {
        contentView.addSubview(newsOwner)
        newsOwner.addSubview(newsDate)
        newsOwner.addSubview(tvTitle)
        
        NSLayoutConstraint.activate([
            newsOwner.topAnchor.constraint(equalTo: newsHeader.bottomAnchor, constant: 2),
            newsOwner.leadingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: 10),
            
            newsDate.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            newsDate.leadingAnchor.constraint(equalTo: newsOwner.leadingAnchor),
            
            tvTitle.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            tvTitle.leadingAnchor.constraint(equalTo: newsDate.trailingAnchor)
        ])
    }
}


extension NewsTableViewCellBBCType: ConfigurableNewsCell {
    func configure(with news: News) {
        tvTitle.text = news.name
        newsDate.text = "\(news.date) | "
        newsHeader.text = news.title
        newsImage.setImage(with: news.image)
    }
}
