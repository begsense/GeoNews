//
//  SearchView.swift
//  GeoNews
//
//  Created by M1 on 15.07.2024.
//

import UIKit

class SearchView: UIViewController {
    //MARK: - Properties
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "მოძებნე სათაურით"
        searchBar.searchTextField.font = UIFont(name: "FiraGO-Regular", size: 12)
        searchBar.backgroundColor = UIColor(red: 0/255, green: 42/255, blue: 69/255, alpha: 1)
        searchBar.searchTextField.textColor = .white
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: searchBar.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        searchBar.searchTextField.leftView?.tintColor = .white
        return searchBar
    }()
    
    private var newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private var nameFilterPicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.backgroundColor = .clear
        return pickerView
    }()
    
    private var categoryFilterPicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = UIColor(red: 0/255, green: 64/255, blue: 99/255, alpha: 1)
        return bottomView
    }()
    
    private var loaderView = CustomLoaderView()
    
    private var viewModel: SearchViewModel
    
    //MARK: - LifeCycle
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bindViewModel()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0/255, green: 42/255, blue: 69/255, alpha: 1)
        
        setupSearchBar()
        setupNewsTableView()
        setupNameFilterPicker()
        setupCategoryFilterPicker()
        setupLoader()
        setupBottomView()
    }
    
    private func setupSearchBar() {
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        searchBar.delegate = self
    }
    
    private func setupNewsTableView() {
        view.addSubview(newsTableView)
        
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            newsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90)
        ])
        
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        newsTableView.register(NewsTableViewCellAppleType.self, forCellReuseIdentifier: NewsTableViewCellAppleType.identifier)
        newsTableView.register(NewsTableViewCellBBCType.self, forCellReuseIdentifier: NewsTableViewCellBBCType.identifier)
        newsTableView.register(NewsTableViewCellFastType.self, forCellReuseIdentifier: NewsTableViewCellFastType.identifier)
        newsTableView.register(NewsTableViewCellCNNType.self, forCellReuseIdentifier: NewsTableViewCellCNNType.identifier)
    }
    
    private func setupNameFilterPicker() {
        view.addSubview(nameFilterPicker)
        
        NSLayoutConstraint.activate([
            nameFilterPicker.topAnchor.constraint(equalTo: newsTableView.bottomAnchor),
            nameFilterPicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            nameFilterPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            nameFilterPicker.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        nameFilterPicker.dataSource = self
        nameFilterPicker.delegate = self
    }
    
    private func setupCategoryFilterPicker() {
        view.addSubview(categoryFilterPicker)
        
        NSLayoutConstraint.activate([
            categoryFilterPicker.topAnchor.constraint(equalTo: newsTableView.bottomAnchor),
            categoryFilterPicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            categoryFilterPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            categoryFilterPicker.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        categoryFilterPicker.dataSource = self
        categoryFilterPicker.delegate = self
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
    
    private func setupBottomView() {
        view.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: nameFilterPicker.bottomAnchor),
            bottomView.widthAnchor.constraint(equalTo: view.widthAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: - ViewModel Binding
    private func bindViewModel() {
        startLoading()
        viewModel.fetchDataHandler()
        
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.stopLoading()
                self?.newsTableView.reloadData()
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

extension SearchView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchNews(byTitle: searchText)
    }
}

extension SearchView: UITableViewDataSource {
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

extension SearchView: UITableViewDelegate {
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
        
        let selectedNews = viewModel.news(at: indexPath.row)
        let newsDetailedViewModel = NewsDetailedViewModel()
        newsDetailedViewModel.selectedNews = selectedNews
        let detailView = NewsDetailedView(viewModel: newsDetailedViewModel)
        
        navigationController?.pushViewController(detailView, animated: true)
    }
}

extension SearchView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == nameFilterPicker {
            return viewModel.names.count
        } else if pickerView == categoryFilterPicker {
            return viewModel.categories.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == nameFilterPicker {
            return viewModel.names[row]
        } else if pickerView == categoryFilterPicker {
            return viewModel.categories[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == nameFilterPicker {
            viewModel.selectedName = viewModel.names[row]
        } else if pickerView == categoryFilterPicker {
            viewModel.selectedCategory = viewModel.categories[row]
        }
        viewModel.applyFiltersHandler()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "FiraGO-Regular", size: 20)
        label.backgroundColor = UIColor(red: 0/255, green: 64/255, blue: 99/255, alpha: 0.6)
        label.layer.cornerRadius = 15
        
        if pickerView == nameFilterPicker {
            label.text = viewModel.names[row]
        } else if pickerView == categoryFilterPicker {
            label.text = viewModel.categories[row]
        }
        return label
    }
}

