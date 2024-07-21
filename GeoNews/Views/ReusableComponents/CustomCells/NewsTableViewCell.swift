//
//  NewsTableViewCell.swift
//  GeoNews
//
//  Created by M1 on 08.07.2024.
//

import UIKit

protocol ConfigurableNewsCell {
    func configure(with news: News)
}

class NewsTableViewCell: UITableViewCell {
    //MARK: Properties:
    static var identifier: String {
        String(describing: self)
    }
    
    private var newsOwner: UIView = {
        let newsOwner = UIView()
        newsOwner.translatesAutoresizingMaskIntoConstraints = false
        newsOwner.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return newsOwner
    }()
    
    private var tvLogo: UIImageView = {
        let tvLogo = UIImageView()
        tvLogo.translatesAutoresizingMaskIntoConstraints = false
        tvLogo.contentMode = .scaleAspectFit
        tvLogo.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tvLogo.widthAnchor.constraint(equalToConstant: 25).isActive = true
        tvLogo.tintColor = UIColor(red: 90/255, green: 191/255, blue: 242/255, alpha: 1)
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
    
    private var detailsArrow: UIImageView = {
        var detailsArrow = UIImageView()
        detailsArrow.translatesAutoresizingMaskIntoConstraints = false
        detailsArrow.image = UIImage(systemName: "arrow")
        detailsArrow.contentMode = .scaleAspectFill
        detailsArrow.tintColor = .white
        detailsArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
        detailsArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
        return detailsArrow
    }()
    
    private var newsDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 10)
        label.textColor = .white
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }()
    
    private var newsHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 13)
        label.textColor = .white
        label.numberOfLines = 0
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }()
    
    private var newsImage: UIImageView = {
        let newsImage = UIImageView()
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsImage.contentMode = .scaleAspectFill
        newsImage.clipsToBounds = true
        newsImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        return newsImage
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
        
        setupNewsOwner()
        setupNewsHeader()
        setupNewsImage()
    }
    
    private func setupNewsOwner() {
        contentView.addSubview(newsOwner)
        newsOwner.addSubview(tvLogo)
        newsOwner.addSubview(tvTitle)
        newsOwner.addSubview(detailsArrow)
        newsOwner.addSubview(newsDate)
        
        NSLayoutConstraint.activate([
            newsOwner.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsOwner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            newsOwner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            tvLogo.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            tvLogo.leadingAnchor.constraint(equalTo: newsOwner.leadingAnchor),
            
            tvTitle.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            tvTitle.leadingAnchor.constraint(equalTo: tvLogo.trailingAnchor, constant: 5),
            
            detailsArrow.centerYAnchor.constraint(equalTo: newsOwner.centerYAnchor),
            detailsArrow.leadingAnchor.constraint(equalTo: tvTitle.trailingAnchor),
            detailsArrow.trailingAnchor.constraint(equalTo: newsOwner.trailingAnchor, constant: -5),
            
            newsDate.topAnchor.constraint(equalTo: tvTitle.bottomAnchor),
            newsDate.leadingAnchor.constraint(equalTo: newsOwner.leadingAnchor),
            
        ])
    }
    
    private func setupNewsHeader() {
        contentView.addSubview(newsHeader)
        
        NSLayoutConstraint.activate([
            newsHeader.topAnchor.constraint(equalTo: newsOwner.bottomAnchor),
            newsHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            newsHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupNewsImage() {
        contentView.addSubview(newsImage)
        
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: newsHeader.bottomAnchor, constant: 10),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}

extension NewsTableViewCell: ConfigurableNewsCell {
    func configure(with news: News) {
        tvLogo.image = UIImage(named: news.name)
        tvTitle.text = news.name
        detailsArrow.image = UIImage(systemName: "arrow.right")
        newsDate.text = news.date
        newsHeader.text = news.title
        newsImage.setImage(with: news.image)
    }
}
