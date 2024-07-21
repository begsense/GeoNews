//
//  NewsTableViewCellFastType.swift
//  GeoNews
//
//  Created by M1 on 21.07.2024.
//

import UIKit

class NewsTableViewCellFastType: UITableViewCell {
    //MARK: Properties:
    static var identifier: String {
        String(describing: self)
    }
    
    private var newsDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 12)
        label.textColor = .white.withAlphaComponent(0.8)
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return label
    }()
    
    private var newsHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return label
    }()
    
    private var tvLogo: UIImageView = {
        let tvLogo = UIImageView()
        tvLogo.translatesAutoresizingMaskIntoConstraints = false
        tvLogo.contentMode = .scaleAspectFit
        tvLogo.heightAnchor.constraint(equalToConstant: 45).isActive = true
        tvLogo.widthAnchor.constraint(equalToConstant: 45).isActive = true
        tvLogo.tintColor = .white
        tvLogo.clipsToBounds = true
        return tvLogo
    }()
    
    private var tvTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 12)
        label.textColor = .white.withAlphaComponent(0.8)
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
    
    //MARK: SetupUI:
    func setupUI() {
        contentView.backgroundColor = .clear
        
        setupNewsDate()
        setupNewsHeader()
        setupNewsTvLogo()
        setupNewsTvTitle()
    }
    
    private func setupNewsDate() {
        contentView.addSubview(newsDate)
        
        NSLayoutConstraint.activate([
            newsDate.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupNewsHeader() {
        contentView.addSubview(newsHeader)
        
        NSLayoutConstraint.activate([
            newsHeader.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75),
            newsHeader.topAnchor.constraint(equalTo: newsDate.bottomAnchor),
            newsHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupNewsTvLogo() {
        contentView.addSubview(tvLogo)
        
        NSLayoutConstraint.activate([
            tvLogo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            tvLogo.leadingAnchor.constraint(equalTo: newsHeader.trailingAnchor, constant: 20)
        ])
    }
    
    private func setupNewsTvTitle() {
        contentView.addSubview(tvTitle)
        
        NSLayoutConstraint.activate([
            tvTitle.topAnchor.constraint(equalTo: newsHeader.bottomAnchor),
            tvTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }
}


extension NewsTableViewCellFastType: ConfigurableNewsCell {
    func configure(with news: News) {
        tvLogo.image = UIImage(named: news.name)
        tvTitle.text = news.name
        newsDate.text = news.date
        newsHeader.text = news.title
    }
}
