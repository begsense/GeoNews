//
//  NewsDetailedView.swift
//  GeoNews
//
//  Created by M1 on 12.07.2024.
//

import UIKit

class NewsDetailedView: UIViewController {
    
    private var viewModel: NewsDetailedViewModel
    
    private var scrollView = UIScrollView()
    
    private var contentView = UIView()
    
    private var newsOwner: UIView = {
        var newsOwner = UIView()
        newsOwner.translatesAutoresizingMaskIntoConstraints = false
        newsOwner.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return newsOwner
    }()
    
    private var tvLogo: UIImageView = {
        var tvLogo = UIImageView()
        tvLogo.translatesAutoresizingMaskIntoConstraints = false
        tvLogo.image = UIImage(named: "logo")
        tvLogo.contentMode = .scaleAspectFit
        tvLogo.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tvLogo.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return tvLogo
    }()
    
    private var tvTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 11)
        label.textColor = .white
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return label
    }()
    
    private var newsDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 11)
        label.textColor = .white
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return label
    }()
    
    private var markedAs: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont(name: "FiraGO-Regular", size: 11)
        label.textColor = .white
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return label
    }()
    
    private var newsFake: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont(name: "FiraGO-Regular", size: 11)
        label.textColor = .red
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return label
    }()
    
    private var newsCategoryTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.text = "Category"
        label.font = UIFont(name: "FiraGO-Regular", size: 11)
        label.textColor = .white
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return label
    }()
    
    private var newsCategory: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont(name: "FiraGO-Regular", size: 11)
        label.textColor = .white
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return label
    }()
    
    private var likesQuantity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont(name: "FiraGO-Regular", size: 11)
        label.textColor = .white
        label.widthAnchor.constraint(equalToConstant: 30).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return label
    }()
    
    private var likesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }()
    
    private var sharesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }()
    
    private var newsHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 19)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var newsDetails: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 15)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var newsImage: UIImageView = {
        var tvLogo = UIImageView()
        tvLogo.translatesAutoresizingMaskIntoConstraints = false
        tvLogo.image = UIImage(named: "logo")
        tvLogo.contentMode = .scaleAspectFill
        tvLogo.clipsToBounds = true
        tvLogo.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return tvLogo
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureUI()
        sharesButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        likesButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    init(viewModel: NewsDetailedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.shareAction = { [weak self] in
            self?.shareContent()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let gradientLayer = GradientLayer(bounds: view.bounds)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        setupScrollView()
        setupHeader()
        setupNewsImage()
        setupNewsOwner()
        setupNewsDetails()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupHeader() {
        contentView.addSubview(newsHeader)
        
        NSLayoutConstraint.activate([
            newsHeader.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            newsHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            newsHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
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
    
    private func setupNewsOwner() {
        contentView.addSubview(newsOwner)
        newsOwner.addSubview(tvLogo)
        newsOwner.addSubview(tvTitle)
        newsOwner.addSubview(newsDate)
        newsOwner.addSubview(newsCategoryTitle)
        newsOwner.addSubview(newsCategory)
        newsOwner.addSubview(markedAs)
        newsOwner.addSubview(newsFake)
        newsOwner.addSubview(likesQuantity)
        newsOwner.addSubview(likesButton)
        newsOwner.addSubview(sharesButton)
        
        NSLayoutConstraint.activate([
            newsOwner.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 10),
            newsOwner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            newsOwner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            tvLogo.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            tvLogo.leadingAnchor.constraint(equalTo: newsOwner.leadingAnchor),
            
            tvTitle.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            tvTitle.leadingAnchor.constraint(equalTo: tvLogo.trailingAnchor, constant: 5),
            
            newsDate.topAnchor.constraint(equalTo: tvTitle.bottomAnchor),
            newsDate.leadingAnchor.constraint(equalTo: tvLogo.trailingAnchor, constant: 5),
            
            newsCategoryTitle.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            newsCategoryTitle.leadingAnchor.constraint(equalTo: newsDate.trailingAnchor, constant: 10),
            
            newsCategory.topAnchor.constraint(equalTo: newsCategoryTitle.bottomAnchor),
            newsCategory.leadingAnchor.constraint(equalTo: newsDate.trailingAnchor, constant: 10),
            
            markedAs.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            markedAs.leadingAnchor.constraint(equalTo: newsCategory.trailingAnchor, constant: 10),
            
            newsFake.topAnchor.constraint(equalTo: markedAs.bottomAnchor),
            newsFake.leadingAnchor.constraint(equalTo: newsCategory.trailingAnchor, constant: 10),
            
            likesQuantity.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            likesQuantity.leadingAnchor.constraint(equalTo: newsFake.trailingAnchor, constant: 10),
            
            likesButton.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            likesButton.leadingAnchor.constraint(equalTo: likesQuantity.trailingAnchor, constant: 5),
            
            sharesButton.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            sharesButton.leadingAnchor.constraint(equalTo: likesButton.trailingAnchor, constant: 5),
        ])
    }
    
    private func setupNewsDetails() {
        contentView.addSubview(newsDetails)
        
        NSLayoutConstraint.activate([
            newsDetails.topAnchor.constraint(equalTo: newsOwner.bottomAnchor, constant: 10),
            newsDetails.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            newsDetails.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            newsDetails.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func configureUI() {
        tvLogo.image = UIImage(named: viewModel.selectedNews?.name ?? "logo")
        newsHeader.text = viewModel.selectedNews?.title
        newsImage.setImage(with: viewModel.selectedNews?.image ?? "logo")
        tvTitle.text = viewModel.selectedNews?.name
        newsDate.text = viewModel.selectedNews?.date
        newsCategory.text = viewModel.selectedNews?.category
        markedAs.text = viewModel.selectedNews?.isfake ?? false ? "Marked As" : ""
        newsFake.text = viewModel.selectedNews?.isfake ?? false ? "Fake News" : ""
        likesQuantity.text = "\(viewModel.selectedNews?.likes ?? 0)"
        newsDetails.text = viewModel.selectedNews?.details
    }
    
    //MARK: Actions
    
    @objc private func shareButtonTapped() {
        viewModel.shareNews()
    }
    
    private func shareContent() {
        let shareText = "\(viewModel.selectedNews?.title ?? "No Information")\n\(viewModel.selectedNews?.details ?? "No Information")"
        var items: [Any] = [shareText]
        items.append(newsImage)
        
        let vc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        vc.popoverPresentationController?.sourceView = sharesButton
        
        present(vc, animated: true)
    }
    
    @objc private func likeButtonTapped() {
        viewModel.updateLikes { [weak self] success in
            if success {
                self?.likesQuantity.text = "\(self?.viewModel.selectedNews?.likes ?? 0)"
                self?.likesButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
            }
        }
    }
}
