//
//  SearchView.swift
//  GeoNews
//
//  Created by M1 on 15.07.2024.
//

import UIKit

class SearchView: UIViewController {

    private var viewModel: SearchViewModel
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "მოძებნე სათაურით"
        searchBar.searchTextField.font = UIFont(name: "FiraGO-Regular", size: 12)
        searchBar.backgroundColor = UIColor(red: 0/255, green: 42/255, blue: 69/255, alpha: 1)
        return searchBar
    }()
    
    let nameFilterPicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = UIColor(red: 4/255, green: 123/255, blue: 128/255, alpha: 1)
        pickerView.layer.cornerRadius = 10
        return pickerView
    }()
    
    let scrollDirection: UIImageView = {
       let scrollIcon = UIImageView()
        scrollIcon.image = UIImage(named: "scroll")
        scrollIcon.tintColor = UIColor(.white.opacity(0.5))
        return scrollIcon
    }()
    
    let categoryFilterPicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = UIColor(red: 4/255, green: 123/255, blue: 128/255, alpha: 1)
        pickerView.layer.cornerRadius = 10
        return pickerView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.backgroundColor = .none
        return tableView
    }()
    
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
        setupBindings()
        viewModel.fetchData()
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
        view.addSubview(scrollDirection)
        view.addSubview(categoryFilterPicker)
        view.addSubview(tableView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        nameFilterPicker.translatesAutoresizingMaskIntoConstraints = false
        scrollDirection.translatesAutoresizingMaskIntoConstraints = false
        categoryFilterPicker.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameFilterPicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameFilterPicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            nameFilterPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            nameFilterPicker.heightAnchor.constraint(equalToConstant: 50),
            
            scrollDirection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            scrollDirection.widthAnchor.constraint(equalToConstant: 20),
            scrollDirection.heightAnchor.constraint(equalToConstant: 40),
            scrollDirection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            categoryFilterPicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryFilterPicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            categoryFilterPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            categoryFilterPicker.heightAnchor.constraint(equalToConstant: 50),
            
            searchBar.topAnchor.constraint(equalTo: nameFilterPicker.bottomAnchor, constant: 15),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 60),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupBindings() {
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        let newsItem = viewModel.news(at: indexPath.row)
        cell.configure(with: newsItem)
        cell.backgroundColor = UIColor(red: 0/255, green: 42/255, blue: 69/255, alpha: 1)
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
        // Handle row selection
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
        label.font = UIFont(name: "FiraGO-Regular", size: 16)
        
        if pickerView == nameFilterPicker {
            label.text = viewModel.names[row]
        } else if pickerView == categoryFilterPicker {
            label.text = viewModel.categories[row]
        }
        return label
    }
    
}

