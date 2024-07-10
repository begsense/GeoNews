//
//  PoliticNews.swift
//  GeoNews
//
//  Created by M1 on 09.07.2024.
//

import UIKit

protocol PoliticNewsViewDelegate: AnyObject {
    func didTapMenuButton()
}

class PoliticNewsView: UIViewController {
    
    // MARK: - UI Components
    private let viewModel = PoliticNewsViewModel()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        return tableView
    }()
    
    weak var delegate: PoliticNewsViewDelegate?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Politics"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapMenuButton))
        setupUI()
        fetchData()
        
        
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
    }
    
    // MARK: - Selectors
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

extension PoliticNewsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        
        let newsItem = viewModel.news(at: indexPath.row)
 
            cell.tvLogo.image = UIImage(named: "logo")
            cell.tvTitle.text = newsItem.name
            cell.detailsArrow.image = UIImage(systemName: "arrow.right")
            cell.newsDate.text = newsItem.date
            cell.newsFake.text = newsItem.isfake ? "Fake News" : "Real News"
            cell.newsHeader.text = newsItem.title
            cell.newsImage.setImage(with: newsItem.image)
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
    
}

extension PoliticNewsView: UITableViewDelegate {
    
}
