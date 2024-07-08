//
//  NewsView.swift
//  GeoNews
//
//  Created by M1 on 02.07.2024.
//

import UIKit

class NewsView: UIViewController {
    
    // MARK: - UI Components
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Loading..."
        label.numberOfLines = 2
        return label
    }()
    
    private var button = CustomButton(title: "Logout", fontSize: .big)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
//        AuthService.shared.fetchUser { [weak self] user, error in
//            guard let self = self else { return }
//            if let error = error {
//                AlertManager.showFetchingUserError(on: self, with: error)
//                return
//            }
//            
//            if let user = user {
//                self.label.text = "\(user.username)\n\(user.score)"
//            }
//        }
//        
//        button.addAction(UIAction { [weak self] _ in
//            self?.didTapLogout()
//        }, for: .touchUpInside)
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .blue
        
        setupTableView()
        
//        view.addSubview(label)
//        view.addSubview(button)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        button.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            button.topAnchor.constraint(equalTo: label.topAnchor, constant: 10),
//            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
//        ])
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

extension NewsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // Return the number of news items. Replace this with your actual data count.
            return 10
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
                return UITableViewCell()
            }
            
            cell.tvLogo.image = UIImage(named: "logo")
            cell.tvTitle.text = "News Title \(indexPath.row + 1)"
            cell.newsDate.text = "Date \(indexPath.row + 1)"
            cell.newsHeader.text = "News Header \(indexPath.row + 1)"
            cell.newsImage.image = UIImage(named: "logo")
            
            return cell
        }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 460
        }
    
}

extension NewsView: UITableViewDelegate {
   
}
