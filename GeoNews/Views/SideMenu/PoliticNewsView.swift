//
//  PoliticNews.swift
//  GeoNews
//
//  Created by M1 on 09.07.2024.
//

import UIKit

class PoliticNewsView: UIViewController {
    
    // MARK: - UI Components
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var button = CustomButton(title: "Logout", fontSize: .big)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = "Politics"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapMenuButton))
        
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }
            
        }
        
        button.addAction(UIAction { [weak self] _ in
            self?.didTapLogout()
        }, for: .touchUpInside)
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        view.addSubview(button)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: button.bottomAnchor),
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
        
    }
    
    @objc private func didTapLogout() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
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
