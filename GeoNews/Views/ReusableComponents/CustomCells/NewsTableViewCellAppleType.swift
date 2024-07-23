//
//  NewsTableViewCellRedditType.swift
//  GeoNews
//
//  Created by M1 on 11.07.2024.
//

import UIKit

class NewsTableViewCellAppleType: UITableViewCell {
    //MARK: - Properties
    static var identifier: String {
        String(describing: self)
    }
    
    private var newsOwner: UIView = {
        let newsOwner = UIView()
        newsOwner.translatesAutoresizingMaskIntoConstraints = false
        newsOwner.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return newsOwner
    }()
    
    private var tvLogo: UIImageView = {
        let tvLogo = UIImageView()
        tvLogo.translatesAutoresizingMaskIntoConstraints = false
        tvLogo.contentMode = .scaleAspectFit
        tvLogo.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tvLogo.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tvLogo.tintColor = .white
        tvLogo.clipsToBounds = true
        return tvLogo
    }()
    
    private var tvTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 16)
        label.textColor = .white
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return label
    }()
    
    private var newsDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 12)
        label.textColor = .white
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }()
    
    private var newsHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 15)
        label.textColor = .white
        label.numberOfLines = 0
        label.heightAnchor.constraint(equalToConstant: 150).isActive = true
        return label
    }()
    
    private var newsImage: UIImageView = {
        let newsImage = UIImageView()
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsImage.contentMode = .scaleAspectFill
        newsImage.clipsToBounds = true
        newsImage.layer.cornerRadius = 15
        newsImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return newsImage
    }()
    
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Setup
    func setupUI() {
        contentView.backgroundColor = .clear
        
        setupNewsOwner()
        setupNewsHeader()
        setupNewsDate()
        setupNewsImage()
    }
    
    private func setupNewsOwner() {
        contentView.addSubview(newsOwner)
        newsOwner.addSubview(tvLogo)
        newsOwner.addSubview(tvTitle)
        
        NSLayoutConstraint.activate([
            newsOwner.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            newsOwner.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsOwner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            tvLogo.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            tvLogo.leadingAnchor.constraint(equalTo: newsOwner.leadingAnchor),
            
            tvTitle.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            tvTitle.leadingAnchor.constraint(equalTo: tvLogo.trailingAnchor, constant: 5)
        ])
    }
    
    private func setupNewsHeader() {
        contentView.addSubview(newsHeader)
        
        NSLayoutConstraint.activate([
            newsHeader.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            newsHeader.topAnchor.constraint(equalTo: newsOwner.bottomAnchor),
            newsHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupNewsDate() {
        contentView.addSubview(newsDate)
        
        NSLayoutConstraint.activate([
            newsDate.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            newsDate.topAnchor.constraint(equalTo: newsHeader.bottomAnchor),
            newsDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupNewsImage() {
        contentView.addSubview(newsImage)
        
        NSLayoutConstraint.activate([
            newsImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            newsImage.leadingAnchor.constraint(equalTo: newsOwner.trailingAnchor, constant: 5),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}

extension NewsTableViewCellAppleType: ConfigurableNewsCell {
    func configure(with news: News) {
        tvLogo.image = UIImage(named: news.name)
        tvTitle.text = news.name
        newsDate.text = news.date
        newsHeader.text = news.title
        newsImage.setImage(with: news.image)
    }
}
