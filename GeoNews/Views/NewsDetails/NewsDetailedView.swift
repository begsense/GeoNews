//
//  NewsDetailedView.swift
//  GeoNews
//
//  Created by M1 on 12.07.2024.
//

import UIKit

class NewsDetailedView: UIViewController {
    //MARK: - Properties
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
    
    private var newsImage: UIImageView = {
        var tvLogo = UIImageView()
        tvLogo.translatesAutoresizingMaskIntoConstraints = false
        tvLogo.image = UIImage(named: "logo")
        tvLogo.contentMode = .scaleAspectFill
        tvLogo.clipsToBounds = true
        tvLogo.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return tvLogo
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
    
    private var readLater: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return button
    }()
    
    private var lineBreak: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 4/255, green: 123/255, blue: 128/255, alpha: 1)
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    private var favorite: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return button
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
    
    private var scrollView = UIScrollView()
    
    private var contentView = UIView()
    
    private var viewModel: NewsDetailedViewModel
    
    //MARK: - Lifecycle
    init(viewModel: NewsDetailedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        setupUI()
        updateUI()
        configureUI()
        setupActions()
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        let gradientLayer = GradientLayer(bounds: view.bounds)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        setupScrollView()
        setupHeader()
        setupNewsImage()
        setupNewsOwner()
        setupReadLaterAndFavoriteLine()
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
            newsCategoryTitle.leadingAnchor.constraint(equalTo: newsDate.trailingAnchor, constant: 30),
            
            newsCategory.topAnchor.constraint(equalTo: newsCategoryTitle.bottomAnchor),
            newsCategory.leadingAnchor.constraint(equalTo: newsDate.trailingAnchor, constant: 30),
            
            likesQuantity.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            likesQuantity.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -135),
            
            likesButton.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            likesButton.leadingAnchor.constraint(equalTo: likesQuantity.trailingAnchor, constant: 5),
            
            sharesButton.topAnchor.constraint(equalTo: newsOwner.topAnchor),
            sharesButton.leadingAnchor.constraint(equalTo: likesButton.trailingAnchor, constant: 5),
        ])
    }
    
    private func setupReadLaterAndFavoriteLine() {
        contentView.addSubview(readLater)
        contentView.addSubview(lineBreak)
        contentView.addSubview(favorite)
        
        NSLayoutConstraint.activate([
            readLater.topAnchor.constraint(equalTo: newsOwner.bottomAnchor, constant: 10),
            readLater.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            lineBreak.topAnchor.constraint(equalTo: newsOwner.bottomAnchor, constant: 20),
            lineBreak.leadingAnchor.constraint(equalTo: readLater.trailingAnchor),
            lineBreak.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            
            favorite.topAnchor.constraint(equalTo: newsOwner.bottomAnchor, constant: 10),
            favorite.leadingAnchor.constraint(equalTo: lineBreak.trailingAnchor)
        ])
    }
    
    private func setupNewsDetails() {
        contentView.addSubview(newsDetails)
        
        NSLayoutConstraint.activate([
            newsDetails.topAnchor.constraint(equalTo: favorite.bottomAnchor, constant: 10),
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
        likesQuantity.text = "\(viewModel.selectedNews?.likes ?? 0)"
        newsDetails.text = viewModel.selectedNews?.details
    }
    
    //MARK: - Actions / ViewModelBinding
    private func setupActions() {
        likesButton.addAction(UIAction { [weak self] _ in
            self?.viewModel.toggleLikes { [weak self] success in
                if success {
                    self?.updateUI()
                }
            }
        }, for: .touchUpInside)
        
        sharesButton.addAction(UIAction { [weak self] _ in
            self?.viewModel.shareNews()
        }, for: .touchUpInside)
        
        readLater.addAction(UIAction { [weak self] _ in
            self?.viewModel.toggleReadLater { [weak self] isReadLater in
                let imageName = isReadLater ? "clock.fill" : "clock"
                self?.readLater.setImage(UIImage(systemName: imageName), for: .normal)
            }
        }, for: .touchUpInside)
        
        favorite.addAction(UIAction { [weak self] _ in
            self?.viewModel.toggleFavorite { [weak self] isFavorite in
                let imageName = isFavorite ? "heart.fill" : "heart"
                self?.favorite.setImage(UIImage(systemName: imageName), for: .normal)
            }
        }, for: .touchUpInside)
        
        viewModel.didShare = { [weak self] in
            self?.shareContent()
        }
    }
    
    private func updateUI() {
        guard let newsTitle = viewModel.selectedNews?.title else { return }
        
        let likedImage = UIImage(systemName: "hand.thumbsup.fill")
        let unlikedImage = UIImage(systemName: "hand.thumbsup")
        likesButton.setImage(UserDefaultsManager.shared.isNewsLiked(newsTitle) ? likedImage : unlikedImage, for: .normal)
        likesQuantity.text = "\(viewModel.selectedNews?.likes ?? 0)"
        
        let readLaterImage = UserDefaultsManager.shared.getReadLaterNews().contains(where: { $0.title == newsTitle }) ? UIImage(systemName: "clock.fill") : UIImage(systemName: "clock")
        readLater.setImage(readLaterImage, for: .normal)
        
        let favoriteImage = UserDefaultsManager.shared.getFavoriteNews().contains(where: { $0.title == newsTitle }) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        favorite.setImage(favoriteImage, for: .normal)
    }
    
    private func shareContent() {
        let shareText = "\(viewModel.selectedNews?.title ?? "No Information")\n\(viewModel.selectedNews?.details ?? "No Information")"
        var items: [Any] = [shareText]
        items.append(newsImage)
        
        let vc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        vc.popoverPresentationController?.sourceView = sharesButton
        present(vc, animated: true)
    }
}
