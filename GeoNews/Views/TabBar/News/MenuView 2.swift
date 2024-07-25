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
    
    private var hello: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 18)
        label.text = "Hello,"
        return label
    }()
    
    private var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "person.crop.circle")
        return imageView
    }()
    
    private var userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 18)
        label.text = "Loading..."
        return label
    }()
    
    private var categories: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "menuBarCell")
        return tableView
    }()
    
    private var userEmail: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 14)
        label.text = "Loading..."
        label.numberOfLines = 2
        return label
    }()
    
    private var logoutButton = CustomButton(title: "Logout", hasBackground: true, fontSize: .med)
    
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
        setupUI()
        bindViewModel()
        logoutAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadProfileImage()
    }
    
    init(viewModel: MenuViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0/255, green: 64/255, blue: 99/255, alpha: 1)
        setupHelloMessage()
        setupUserName()
        setupCategories()
        setupLogoutButton()
        setupUserEmail()
    }
    
    private func setupHelloMessage() {
        view.addSubview(hello)
        
        NSLayoutConstraint.activate([
            hello.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            hello.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            hello.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupUserName() {
        let userInfoStackView = UIStackView(arrangedSubviews: [profileImage, userName])
        userInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        userInfoStackView.axis = .horizontal
        userInfoStackView.spacing = 10
        userInfoStackView.alignment = .center

        view.addSubview(userInfoStackView)

        NSLayoutConstraint.activate([
            userInfoStackView.topAnchor.constraint(equalTo: hello.bottomAnchor, constant: 5),
            userInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupCategories() {
        view.addSubview(categories)
        
        NSLayoutConstraint.activate([
            categories.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 70),
            categories.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            categories.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categories.heightAnchor.constraint(equalToConstant: 350)
        ])
        
        categories.dataSource = self
        categories.delegate = self
    }
    
    private func setupLogoutButton() {
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoutButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func setupUserEmail() {
        view.addSubview(userEmail)
        userEmail.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userEmail.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -15),
            userEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func logoutAction() {
        logoutButton.addAction(UIAction { [weak self] _ in
            self?.didTapLogout()
        }, for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel.fetchUserData()
        
        viewModel.updateUserName = { [weak self] text in
            self?.userName.text = text
            self?.loadProfileImage()
        }
        
        viewModel.updateUserEmail = { [weak self] text in
            self?.userEmail.text = text
        }
        
        viewModel.logoutSuccess = { [weak self] in
            if let sceneDelegate = self?.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
        
        viewModel.logoutFailure = { [weak self] error in
            guard let self = self else { return }
            AlertManager.showLogoutError(on: self)
        }
    }
    
    private func didTapLogout() {
        viewModel.logout()
    }
    
    private func loadProfileImage() {
        if let profileImage = FileManagerHelper.shared.loadProfileImage() {
            self.profileImage.image = profileImage
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
        cell.imageView?.image = UIImage(named: menuOptions.allCases[indexPath.row].rawValue)
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
