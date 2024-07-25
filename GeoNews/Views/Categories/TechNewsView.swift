//
//  TechNewsView.swift
//  GeoNews
//
//  Created by M1 on 10.07.2024.
//

import UIKit

class TechNewsView: UIViewController {
    //MARK: - Properties
    private var techNewsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var techNewsTitle: UILabel = {
        let label = UILabel()
        label.text = "Tech"
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Regular", size: 16)
        return label
    }()
    
    private var loaderView = CustomLoaderView()
    
    private var viewModel: TechNewsViewModel
    
    //MARK: - LifeCycle
    init(viewModel: TechNewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = techNewsTitle
        
        setupUI()
        bindViewModel()
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        let gradientLayer = GradientLayer(bounds: view.bounds)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        setupTableView()
        setupLoader()
    }
    
    func setupTableView() {
        view.addSubview(techNewsTableView)
        
        NSLayoutConstraint.activate([
            techNewsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            techNewsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            techNewsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            techNewsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        techNewsTableView.dataSource = self
        techNewsTableView.delegate = self
        techNewsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        techNewsTableView.register(NewsTableViewCellAppleType.self, forCellReuseIdentifier: NewsTableViewCellAppleType.identifier)
        techNewsTableView.register(NewsTableViewCellBBCType.self, forCellReuseIdentifier: NewsTableViewCellBBCType.identifier)
        techNewsTableView.register(NewsTableViewCellFastType.self, forCellReuseIdentifier: NewsTableViewCellFastType.identifier)
        techNewsTableView.register(NewsTableViewCellCNNType.self, forCellReuseIdentifier: NewsTableViewCellCNNType.identifier)
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
    
    //MARK: - ViewModel Binding
    private func bindViewModel() {
        startLoading()
        
        viewModel.fetchDataHandler()
        
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.stopLoading()
                self?.techNewsTableView.reloadData()
            }
        }
        
        viewModel.hasError = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.stopLoading()
                AlertManager.fetchingUserError(on: self)
            }
        }
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
extension TechNewsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = viewModel.cellIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let newsItem = viewModel.news(at: indexPath.row)
        
        if let configurableCell = cell as? ConfigurableNewsCell {
            configurableCell.configure(with: newsItem)
        }
        
        cell.contentView.backgroundColor = UIColor(red: 0/255, green: 42/255, blue: 69/255, alpha: 1)
        
        return cell
    }
}

extension TechNewsView: UITableViewDelegate {
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
