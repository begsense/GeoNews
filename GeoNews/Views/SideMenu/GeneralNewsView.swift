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
    
    // MARK: - UI Components
    private let viewModel = GeneralNewsViewModel()
    private var menuViewModel: MenuViewModel!
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        return tableView
    }()
    
    weak var delegate: GeneralNewsViewDelegate?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            menuViewModel = sceneDelegate.sharedMenuViewModel
        }
        title = "All News"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapMenuButton))
        
        setupUI()
        fetchData()
        reloadTableViewCells()
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.register(NewsTableViewCellRedditType.self, forCellReuseIdentifier: NewsTableViewCellRedditType.identifier)
    }
    
    // MARK: - Selectors
    func reloadTableViewCells() {
        print("reload")
        menuViewModel.changeCellStyles = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    
    @objc private func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
    
    
    private func fetchData() {
        viewModel.fetchData()
        
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension GeneralNewsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuViewModel.currentCellIdentifier, for: indexPath)
        
        let newsItem = viewModel.news(at: indexPath.row)
        
        if let configurableCell = cell as? ConfigurableNewsCell {
            configurableCell.configure(with: newsItem)
        }
        
        return cell
    }
}

extension GeneralNewsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedNews = viewModel.news(at: indexPath.row)
        let generalNewsDetailedViewModel = GeneralNewsDetailedViewModel()
        generalNewsDetailedViewModel.selectedNews = selectedNews
        let detailView = NewsDetailedView(viewModel: generalNewsDetailedViewModel)
        
        navigationController?.pushViewController(detailView, animated: true)
    }
}
