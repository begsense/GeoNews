//
//  SearchViewModel.swift
//  GeoNews
//
//  Created by M1 on 15.07.2024.
//

import Foundation

class SearchViewModel {
    @Published private(set) var newsItems: [News] = []
    var onDataUpdate: (() -> Void)?
    
    private let networkService = NetworkService()
    private var allNewsItems: [News] = []
    
    let names = ["TV", "Imedi", "Rustavi2", "On.ge", "Formula"]
    let categories = ["Category", "Politics", "Sport", "Health", "Technology"]
    
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
    
    func fetchData() {
        networkService.fetchData { [weak self] newsItems in
            guard let self = self else { return }
            self.allNewsItems = newsItems
            self.applyFilters()
        }
    }
    
    func searchNews(byTitle title: String) {
        applyFilters(searchTitle: title)
    }
    
    func applyFilters(searchTitle: String = "") {
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
        
        self.newsItems = filteredNews
        self.onDataUpdate?()
    }
    
    func numberOfItems() -> Int {
        return newsItems.count
    }
    
    func news(at index: Int) -> News {
        return newsItems[index]
    }
}
