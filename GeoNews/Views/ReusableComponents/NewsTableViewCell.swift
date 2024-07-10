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
        tvLogo.heightAnchor.constraint(equalToConstant: 25).isActive = true
        tvLogo.widthAnchor.constraint(equalToConstant: 25).isActive = true
        return tvLogo
    }()
    
    var tvTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = UIColor(red: 231/255, green: 161/255, blue: 21/255, alpha: 1)
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return label
    }()
    
    var detailsArrow: UIImageView = {
        var tvLogo = UIImageView()
        tvLogo.translatesAutoresizingMaskIntoConstraints = false
        tvLogo.image = UIImage(systemName: "arrow")
        tvLogo.contentMode = .scaleAspectFill
        tvLogo.heightAnchor.constraint(equalToConstant: 25).isActive = true
        tvLogo.widthAnchor.constraint(equalToConstant: 10).isActive = true
        return tvLogo
    }()
    
    var newsDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 8, weight: .regular)
        label.textColor = UIColor(red: 231/255, green: 161/255, blue: 21/255, alpha: 1)
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }()
    
    var newsFake: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 8, weight: .regular)
        label.textColor = .red
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }()
    
    var newsHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor(red: 231/255, green: 161/255, blue: 21/255, alpha: 1)
        label.numberOfLines = 3
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }()
    
    var newsImage: UIImageView = {
        var tvLogo = UIImageView()
        tvLogo.translatesAutoresizingMaskIntoConstraints = false
        tvLogo.image = UIImage(named: "logo")
        tvLogo.contentMode = .scaleAspectFill
        tvLogo.clipsToBounds = true
        tvLogo.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return tvLogo
    }()
    
    var spacer: UIView = {
        var spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.heightAnchor.constraint(equalToConstant: 25).isActive = true
        return spacer
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
        tvLogo.layer.cornerRadius = 12.5
        tvLogo.layer.masksToBounds = true
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
        newsOwner.addSubview(newsFake)
        
        NSLayoutConstraint.activate([
            newsOwner.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            newsOwner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            newsOwner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            
            tvLogo.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            tvLogo.leadingAnchor.constraint(equalTo: newsOwner.leadingAnchor),
            
            tvTitle.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            tvTitle.leadingAnchor.constraint(equalTo: tvLogo.trailingAnchor, constant: 5),
            
            detailsArrow.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            detailsArrow.leadingAnchor.constraint(equalTo: tvTitle.trailingAnchor),
            detailsArrow.trailingAnchor.constraint(equalTo: newsOwner.trailingAnchor, constant: -5),
            
            newsDate.topAnchor.constraint(equalTo: tvTitle.bottomAnchor),
            newsDate.leadingAnchor.constraint(equalTo: newsOwner.leadingAnchor),
            
            newsFake.topAnchor.constraint(equalTo: tvTitle.bottomAnchor),
            newsFake.leadingAnchor.constraint(equalTo: newsDate.trailingAnchor),
            newsFake.trailingAnchor.constraint(equalTo: newsOwner.trailingAnchor)
            
        ])
    }
    
    private func setupNewsHeader() {
        contentView.addSubview(newsHeader)
        
        NSLayoutConstraint.activate([
            newsHeader.topAnchor.constraint(equalTo: newsOwner.bottomAnchor, constant: 10),
            newsHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            newsHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])
    }
    
    private func setupNewsImage() {
        contentView.addSubview(newsImage)
        
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: newsHeader.bottomAnchor, constant: 10),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
}
