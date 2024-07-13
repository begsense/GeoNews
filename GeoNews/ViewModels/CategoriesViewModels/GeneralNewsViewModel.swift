//
//  GeneralNewsViewModel.swift
//  GeoNews
//
//  Created by M1 on 10.07.2024.
//

import Foundation

class GeneralNewsViewModel: ObservableObject {
    @Published private(set) var newsItems: [News] = []
    var onDataUpdate: (() -> Void)?
    
    private let networkService = NetworkService()
    private var profileViewModel: ProfileViewModel?
    
    init(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
        self.profileViewModel?.onDataUpdate = { [weak self] filteredNews in
            self?.updateNews(with: filteredNews)
        }
    }
    
    func fetchData() {
        networkService.fetchData { [weak self] newsItems in
            guard let self = self else { return }
            
            self.newsItems = newsItems.sorted {
                guard let date1 = $0.dateObject, let date2 = $1.dateObject else { return false }
                return date1 > date2
            }
            
            self.profileViewModel?.onDataUpdate?(newsItems)
            self.onDataUpdate?()
        }
    }
    
    func updateNews(with news: [News]) {
        self.newsItems = news.sorted {
            guard let date1 = $0.dateObject, let date2 = $1.dateObject else { return false }
            return date1 > date2
        }
        self.onDataUpdate?()
    }
    
    func numberOfItems() -> Int {
        return newsItems.count
    }
    
    func news(at index: Int) -> News {
        return newsItems[index]
    }
}
