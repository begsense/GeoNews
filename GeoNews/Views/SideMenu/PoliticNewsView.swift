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
        setupUI()
        title = "Politics"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapMenuButton))
        
      
        
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
    
   
}

extension PoliticNewsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        
        cell.tvLogo.image = UIImage(named: "logo")
        cell.tvTitle.text = "News Title \(indexPath.row + 1)"
        cell.detailsArrow.image = UIImage(systemName: "arrow.right")
        cell.newsDate.text = "Date \(indexPath.row + 1)"
        cell.newsFake.text = "Fake \(indexPath.row + 1)"
        cell.newsHeader.text = "News Header \(indexPath.row + 1)"
        cell.newsImage.image = UIImage(named: "logo")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 340
       }
    
}

extension PoliticNewsView: UITableViewDelegate {
    
}
