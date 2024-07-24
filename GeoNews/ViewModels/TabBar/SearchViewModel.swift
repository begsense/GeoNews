//
//  SearchViewModel.swift
//  GeoNews
//
//  Created by M1 on 15.07.2024.
//

import Foundation

class SearchViewModel {
    //MARK: - Properties
    private var allNewsItems: [News] = []
    
    private var filteredNewsItems: [News] = [] {
        didSet {
            onDataUpdate?()
        }
    }
    
    var onDataUpdate: (() -> Void)?
    
    var isError: ((Bool) -> Void)?
    
    var names = ["TV", "Imedi", "Rustavi2", "On.ge", "Formula", "1TV"]
    
    var categories = ["Category", "Politics", "Sport", "Health", "Technology"]
    
    var selectedName: String = "TV" {
        didSet {
            applyFilters()
        }
    }
    
    var selectedCategory: String = "Category" {
        didSet {
            applyFilters()
        }
    }
    
    var cellIdentifier: String = NewsTableViewCell.identifier {
        didSet {
            onDataUpdate?()
        }
    }
    
    var numberOfItems: Int {
        filteredNewsItems.count
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(cellStyleChanged(_:)), name: .cellStyleChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .cellStyleChanged, object: nil)
    }
    
    // MARK: - Public Methods
    func searchNews(byTitle title: String) {
        applyFilters(searchTitle: title)
    }
    
    func news(at index: Int) -> News {
        return filteredNewsItems[index]
    }
    
    func fetchDataHandler() {
        getData()
    }
    
    func applyFiltersHandler() {
        applyFilters()
    }
    
    //MARK: - Private functions
    private func getData() {
        NetworkService().fetchData { [weak self] newsItems in
            guard let self = self else { return }
            if newsItems.isEmpty {
                self.isError?(true)
            } else {
                self.allNewsItems = newsItems
                self.applyFilters()
            }
        }
    }
    
    @objc private func cellStyleChanged(_ notification: Notification) {
        if let newCellIdentifier = notification.object as? String {
            cellIdentifier = newCellIdentifier
        }
    }
    
    private func applyFilters(searchTitle: String = "") {
        var filteredNews = allNewsItems
        
        if selectedName != "TV" {
            filteredNews = filteredNews.filter { $0.name == selectedName }
        }
        
        if selectedCategory != "Category" {
            filteredNews = filteredNews.filter { $0.category == selectedCategory }
        }
        
        if !searchTitle.isEmpty {
            filteredNews = filteredNews.filter { $0.title.lowercased().contains(searchTitle.lowercased()) }
        }
        
        filteredNews.sort {
            guard let date1 = $0.dateObject, let date2 = $1.dateObject else { return false }
            return date1 > date2
        }
        
        self.filteredNewsItems = filteredNews
    }
}
