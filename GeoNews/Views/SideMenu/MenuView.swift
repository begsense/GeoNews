//
//  MenuView.swift
//  GeoNews
//
//  Created by M1 on 09.07.2024.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuView.menuOptions)
}

class MenuView: UIViewController {
    
    weak var delegate: MenuViewControllerDelegate?
    
    var viewModel: MenuViewModel
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 20)
        label.text = "Loading..."
        label.numberOfLines = 2
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "menuBarCell")
        return tableView
    }()
    
    private var button = CustomButton(title: "Logout", hasBackground: true, fontSize: .med)
    
    enum menuOptions: String, CaseIterable {
        case general = "General"
        case politics = "Politics"
        case sports = "Sport"
        case health = "Health"
        case tech = "Tech"
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        setupUI()
        viewModel.fetchUserData()
        
        button.addAction(UIAction { [weak self] _ in
            self?.didTapLogout()
        }, for: .touchUpInside)
        
    }
    
    init(viewModel: MenuViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBindings() {
        viewModel.updateUserLabel = { [weak self] text in
            self?.label.text = text
        }
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0/255, green: 64/255, blue: 99/255, alpha: 1)
        view.addSubview(button)
        view.addSubview(label)
        button.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.widthAnchor.constraint(equalToConstant: 180)
        ])
        
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            tableView.widthAnchor.constraint(equalToConstant: 100),
            tableView.heightAnchor.constraint(equalToConstant: 350)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc private func didTapLogout() {
        viewModel.logout { [weak self] error in
            guard let self = self else { return }
            if error != nil {
                AlertManager.showLogoutError(on: self)
                return
            }
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
}

extension MenuView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuBarCell", for: indexPath)
        
        cell.textLabel?.text = menuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.font = UIFont(name: "FiraGO-Regular", size: 16)
        cell.contentView.backgroundColor = UIColor(red: 0/255, green: 64/255, blue: 99/255, alpha: 1)
        cell.textLabel?.textColor = .white
        
        return cell
    }
}

extension MenuView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = menuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
}
