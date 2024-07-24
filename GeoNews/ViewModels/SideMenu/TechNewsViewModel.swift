//
//  TechNewsViewModel.swift
//  GeoNews
//
//  Created by M1 on 11.07.2024.
//

import Foundation

class TechNewsViewModel {
    private var newsItems: [News] = []
    var onDataUpdate: (() -> Void)?
    
    private let networkService = NetworkService()
    
    var cellIdentifier: String = NewsTableViewCell.identifier
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(cellStyleChanged(_:)), name: .cellStyleChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .cellStyleChanged, object: nil)
    }
    
    func fetchData() {
        networkService.fetchData(filterBy: "category", equalTo: "Technology") { [weak self] newsItems in
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
    
    @objc func cellStyleChanged(_ notification: Notification) {
        if let newCellIdentifier = notification.object as? String {
            cellIdentifier = newCellIdentifier
            onDataUpdate?()
        }
    }
}
