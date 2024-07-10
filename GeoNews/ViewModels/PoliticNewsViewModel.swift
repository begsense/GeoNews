//
//  PoliticNewsViewModel.swift
//  GeoNews
//
//  Created by M1 on 10.07.2024.
//

import Foundation

class PoliticNewsViewModel {
    private var newsItems: [News] = []
    var onDataUpdate: (() -> Void)?
    
    private let networkService = NetworkService()
    
    func fetchData() {
        networkService.fetchData(forField: "category", equalTo: "politics") { [weak self] newsItems in
            guard let self = self else { return }
            
            self.newsItems = newsItems
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
