//
//  PoliticNews.swift
//  GeoNews
//
//  Created by M1 on 09.07.2024.
//

import UIKit

protocol GeneralNewsViewDelegate: AnyObject {
    func didTapMenuButton()
}

class GeneralNewsView: UIViewController {
    //MARK: - Properties
    private var newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var newsTitle: UILabel = {
        let label = UILabel()
        label.text = "All News"
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Regular", size: 16)
        return label
    }()
    
    private var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = UIColor(red: 0/255, green: 64/255, blue: 99/255, alpha: 1)
        return bottomView
    }()
    
    private var loaderView = CustomLoaderView()
    
    weak var delegate: GeneralNewsViewDelegate?
    
    private var viewModel: GeneralNewsViewModel
    
    //MARK: - LifeCycle
    init(viewModel: GeneralNewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = newsTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapMenuButton))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = logoBarButtonItem()
        
        setupUI()
        bindViewModel()
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        let gradientLayer = GradientLayer(bounds: view.bounds)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        setupBottomSafeArea()
        setupTableView()
        setupLoader()
    }
    
    func setupTableView() {
        view.addSubview(newsTableView)
        
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor)
        ])
        
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        newsTableView.register(NewsTableViewCellAppleType.self, forCellReuseIdentifier: NewsTableViewCellAppleType.identifier)
        newsTableView.register(NewsTableViewCellBBCType.self, forCellReuseIdentifier: NewsTableViewCellBBCType.identifier)
        newsTableView.register(NewsTableViewCellFastType.self, forCellReuseIdentifier: NewsTableViewCellFastType.identifier)
        newsTableView.register(NewsTableViewCellCNNType.self, forCellReuseIdentifier: NewsTableViewCellCNNType.identifier)
    }
    
    private func setupLoader() {
        view.addSubview(loaderView)
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.isHidden = true
        
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupBottomSafeArea() {
        view.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: - ViewModel Binding
    private func bindViewModel() {
        startLoading()
        
        viewModel.fetchDataHandler()
        
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.stopLoading()
                self?.newsTableView.reloadData()
            }
        }
        
        viewModel.hasError = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.stopLoading()
                AlertManager.fetchingUserError(on: self)
            }
        }
        
        viewModel.onMenuButtonTapped = { [weak self] in
            self?.delegate?.didTapMenuButton()
        }
    }
    
    @objc private func didTapMenuButton() {
        viewModel.handleMenuButtonTap()
    }
    
    private func logoBarButtonItem() -> UIBarButtonItem {
        let logoImage = UIImage(named: "logo")
        let logoImageView = UIImageView(image: logoImage)
        logoImageView.contentMode = .scaleAspectFit
        
        let logoSize: CGFloat = 34
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.heightAnchor.constraint(equalToConstant: logoSize).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: logoSize).isActive = true
        
        let logoBarButtonItem = UIBarButtonItem(customView: logoImageView)
        logoBarButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        logoBarButtonItem.customView?.heightAnchor.constraint(equalToConstant: logoSize).isActive = true
        logoBarButtonItem.customView?.widthAnchor.constraint(equalToConstant: logoSize).isActive = true
        
        return logoBarButtonItem
    }
    
    //MARK: - Loader
    private func startLoading() {
        loaderView.startAnimating()
    }
    
    private func stopLoading() {
        loaderView.stopAnimating()
    }
}

//MARK: - Extensions
extension GeneralNewsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)
        
        let newsItem = viewModel.news(at: indexPath.row)
        
        if let configurableCell = cell as? ConfigurableNewsCell {
            configurableCell.configure(with: newsItem)
        }
        
        cell.contentView.backgroundColor = UIColor(red: 0/255, green: 42/255, blue: 69/255, alpha: 1)
        return cell
    }
}

extension GeneralNewsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.cellIdentifier  {
        case NewsTableViewCell.identifier:
            return 275
        case NewsTableViewCellAppleType.identifier:
            return 220
        case NewsTableViewCellBBCType.identifier:
            return 170
        case NewsTableViewCellFastType.identifier:
            return 130
        case NewsTableViewCellCNNType.identifier:
            return 220
        default:
            return 275
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.onNewsSelected = { [weak self] news in
            guard let self = self else { return }
            let newsDetailedViewModel = NewsDetailedViewModel()
            newsDetailedViewModel.selectedNews = news
            let detailView = NewsDetailedView(viewModel: newsDetailedViewModel)
            
            self.navigationController?.pushViewController(detailView, animated: true)
        }
        
        viewModel.navigateToNewsDetails(index: indexPath.row)
    }
}
