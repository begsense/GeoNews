//
//  NewsTableViewCell.swift
//  GeoNews
//
//  Created by M1 on 08.07.2024.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    //MARK: Properties:
    static var identifier: String {
        String(describing: self)
    }
    
    var newsOwner: UIView = {
       var newsOwner = UIView()
        newsOwner.translatesAutoresizingMaskIntoConstraints = false
        newsOwner.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return newsOwner
    }()
    
    var tvLogo: UIImageView = {
        var tvLogo = UIImageView()
        tvLogo.translatesAutoresizingMaskIntoConstraints = false
        tvLogo.image = UIImage(systemName: "home")
        tvLogo.contentMode = .scaleAspectFill
        tvLogo.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tvLogo.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return tvLogo
    }()
    
    var tvTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = UIColor.white
        label.numberOfLines = 3
        return label
    }()
    
    var newsDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.white
        label.numberOfLines = 3
        return label
    }()
    
    var newsHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor.white
        label.numberOfLines = 3
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }()
    
    var newsImage: UIImageView = {
        var tvLogo = UIImageView()
        tvLogo.translatesAutoresizingMaskIntoConstraints = false
        tvLogo.image = UIImage(named: "logo")
        tvLogo.contentMode = .scaleAspectFill
        tvLogo.heightAnchor.constraint(equalToConstant: 300).isActive = true
        return tvLogo
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
        setupNewsOwner()
        setupNewsHeader()
        setupNewsImage()
    }
    
    private func setupNewsOwner() {
        contentView.addSubview(newsOwner)
        newsOwner.addSubview(tvLogo)
        newsOwner.addSubview(tvTitle)
        newsOwner.addSubview(newsDate)
        
        NSLayoutConstraint.activate([
            newsOwner.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            newsOwner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            newsOwner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            
            tvLogo.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            tvLogo.leadingAnchor.constraint(equalTo: newsOwner.leadingAnchor),
            tvLogo.widthAnchor.constraint(equalToConstant: 50),
            tvLogo.heightAnchor.constraint(equalToConstant: 50),
            
            tvTitle.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            tvTitle.leadingAnchor.constraint(equalTo: tvLogo.trailingAnchor),
            tvTitle.trailingAnchor.constraint(equalTo: newsOwner.trailingAnchor),
            tvTitle.heightAnchor.constraint(equalToConstant: 25),
            
            newsDate.topAnchor.constraint(equalTo: tvTitle.bottomAnchor),
            newsDate.leadingAnchor.constraint(equalTo: tvLogo.trailingAnchor),
            newsDate.trailingAnchor.constraint(equalTo: newsOwner.trailingAnchor),
            newsDate.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setupNewsHeader() {
        contentView.addSubview(newsHeader)
        
        NSLayoutConstraint.activate([
            newsHeader.topAnchor.constraint(equalTo: newsOwner.bottomAnchor, constant: 10),
            newsHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            newsHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
        ])
    }
    
    private func setupNewsImage() {
        contentView.addSubview(newsImage)
        
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: newsHeader.bottomAnchor, constant: 10),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
}
