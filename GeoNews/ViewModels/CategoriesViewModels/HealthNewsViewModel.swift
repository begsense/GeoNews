//
//  HealthNewsViewModel.swift
//  GeoNews
//
//  Created by M1 on 11.07.2024.
//

import Foundation

class HealthNewsViewModel {
    private var newsItems: [News] = []
    var onDataUpdate: (() -> Void)?
    
    private let networkService = NetworkService()
    
    func fetchData() {
        networkService.fetchData(filterBy: "category", equalTo: "Health") { [weak self] newsItems in
            guard let self = self else { return }
            
            self.newsItems = newsItems.sorted {
                guard let date1 = $0.dateObject, let date2 = $1.dateObject else { return false }
                return date1 > date2
            }
            
            self.onDataUpdate?()
        }
    }
    
    func numberOfItems() -> Int {
        return newsItems.count
    }
    
    func news(at index: Int) -> News {
        return newsItems[index]
    }
}
