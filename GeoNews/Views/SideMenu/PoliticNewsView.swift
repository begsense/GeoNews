//
//  PoliticsNewsView.swift
//  GeoNews
//
//  Created by M1 on 11.07.2024.
//

import UIKit

class PoliticNewsView: UIViewController {
    
    private let viewModel = PoliticsNewsViewModel()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        return tableView
    }()
    
    weak var delegate: GeneralNewsViewDelegate?
    
    var currentCellIdentifier = NewsTableViewCell.identifier
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Politics"
        setupUI()
        fetchData()
    }
    
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
    
    @objc private func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
    
    @objc private func didTapRightMenuButton() {
        showDropdownMenu()
    }
    
    private func showDropdownMenu() {
        let alertController = UIAlertController(title: "Change Design", message: "Choose the desired style", preferredStyle: .actionSheet)
        
        let option1 = UIAlertAction(title: "General", style: .default) { _ in
            self.handleDropdownSelection(identifier: NewsTableViewCell.identifier)
        }
        let option2 = UIAlertAction(title: "Test, Cover Image -height", style: .default) { _ in
            self.handleDropdownSelection(identifier: NewsTableViewCellRedditType.identifier)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(option1)
        alertController.addAction(option2)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func handleDropdownSelection(identifier: String) {
        currentCellIdentifier = identifier
        tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: currentCellIdentifier, for: indexPath)
        
        let newsItem = viewModel.news(at: indexPath.row)
        
        if let configurableCell = cell as? ConfigurableNewsCell {
            configurableCell.configure(with: newsItem)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
}

extension PoliticNewsView: UITableViewDelegate {
   
}
