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
    
    var menuViewModel: MenuViewModel!
    
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
    
    private let buttonChangeStyle = CustomButton(title: "Change Style", hasBackground: true, fontSize: .med)
    
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
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            menuViewModel = sceneDelegate.sharedMenuViewModel
        }
        
        setupBindings()
        setupUI()
        menuViewModel.fetchUserData()
        
        button.addAction(UIAction { [weak self] _ in
            self?.didTapLogout()
        }, for: .touchUpInside)
        
        buttonChangeStyle.addAction(UIAction { [weak self] _ in
            self?.didClickChangeStyleButton()
        }, for: .touchUpInside)
    }
    
    private func setupBindings() {
        menuViewModel.updateUserLabel = { [weak self] text in
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
        setupChangeStyleButton()
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
    
    func setupChangeStyleButton() {
        view.addSubview(buttonChangeStyle)
        buttonChangeStyle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonChangeStyle.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            buttonChangeStyle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            buttonChangeStyle.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func didClickChangeStyleButton() {
        showChangeStyleMenu()
    }
    
    private func showChangeStyleMenu() {
        let alertController = UIAlertController(title: "Change Design", message: "Choose the desired style", preferredStyle: .actionSheet)
        
        let option1 = UIAlertAction(title: "StaticCell", style: .default) { [weak self] _ in
            print("მოინიშნა StaticCell")
            self?.menuViewModel.currentCellIdentifier = NewsTableViewCell.identifier
        }
        let option2 = UIAlertAction(title: "RedditType", style: .default) { [weak self] _ in
            print("მოინიშნა RedditType")
            self?.menuViewModel.currentCellIdentifier = NewsTableViewCellRedditType.identifier
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(option1)
        alertController.addAction(option2)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func didTapLogout() {
        menuViewModel.logout { [weak self] error in
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
