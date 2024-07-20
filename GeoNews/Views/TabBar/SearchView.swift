//
//  SearchView.swift
//  GeoNews
//
//  Created by M1 on 15.07.2024.
//

import UIKit

class SearchView: UIViewController {

    private var viewModel: SearchViewModel
    
    private var profileViewModel: ProfileViewModel
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
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
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    let nameFilterPicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .clear
        return pickerView
    }()
    
    let categoryFilterPicker: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    let bottomView: UIView = {
       let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = UIColor(red: 0/255, green: 64/255, blue: 99/255, alpha: 1)
        return bottomView
    }()
    
    init(viewModel: SearchViewModel, profileViewModel: ProfileViewModel) {
        self.viewModel = viewModel
        self.profileViewModel = profileViewModel
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
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0/255, green: 42/255, blue: 69/255, alpha: 1)
        
        searchBar.delegate = self
        nameFilterPicker.dataSource = self
        nameFilterPicker.delegate = self
        categoryFilterPicker.dataSource = self
        categoryFilterPicker.delegate = self
        
        view.addSubview(searchBar)
        view.addSubview(nameFilterPicker)
        view.addSubview(categoryFilterPicker)
        view.addSubview(tableView)
        view.addSubview(bottomView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        nameFilterPicker.translatesAutoresizingMaskIntoConstraints = false
        categoryFilterPicker.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90),
            
            nameFilterPicker.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            nameFilterPicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            nameFilterPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            nameFilterPicker.heightAnchor.constraint(equalToConstant: 90),
            
            categoryFilterPicker.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            categoryFilterPicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            categoryFilterPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            categoryFilterPicker.heightAnchor.constraint(equalToConstant: 90),
            
            bottomView.topAnchor.constraint(equalTo: nameFilterPicker.bottomAnchor),
            bottomView.widthAnchor.constraint(equalTo: view.widthAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.register(NewsTableViewCellRedditType.self, forCellReuseIdentifier: NewsTableViewCellRedditType.identifier)
    }
    
    private func bindViewModel() {
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.fetchData()
    }
}

extension SearchView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchNews(byTitle: searchText)
    }
}

extension SearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
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
        return 280
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedNews = viewModel.news(at: indexPath.row)
        let newsDetailedViewModel = NewsDetailedViewModel()
        newsDetailedViewModel.selectedNews = selectedNews
        let detailView = NewsDetailedView(viewModel: newsDetailedViewModel)
        
        navigationController?.pushViewController(detailView, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
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
        viewModel.applyFilters()
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

