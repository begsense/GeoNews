//
//  HealthNewsViewModel.swift
//  GeoNews
//
//  Created by M1 on 11.07.2024.
//

import Foundation

class HealthNewsViewModel {
    private var healthNewsItems: [News] = []
    
    var numberOfItems: Int { healthNewsItems.count }
    
    var onDataUpdate: (() -> Void)?
    
    var hasError: ((Bool) -> Void)?
    
    var onNewsSelected: ((News) -> Void)?
    
    var cellIdentifier: String = NewsTableViewCell.identifier
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(cellStyleChanged(_:)), name: .cellStyleChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .cellStyleChanged, object: nil)
    }
    
    func fetchDataHandler() {
        getData()
    }
    
    func news(at index: Int) -> News {
        return healthNewsItems[index]
    }
    
    func navigateToNewsDetails(index: Int) {
        self.onNewsSelected?(healthNewsItems[index])
    }
    
    //MARK: - Private functions
    private func getData() {
        NetworkService().fetchData(filterBy: "category", equalTo: "Health") { [weak self] newsItems in
            guard let self = self else { return }
            
            if newsItems.isEmpty {
                self.hasError?(true)
            } else {
                self.healthNewsItems = newsItems.sorted {
                    guard let date1 = $0.dateObject, let date2 = $1.dateObject else { return false }
                    return date1 > date2
                }
                
                self.onDataUpdate?()
            }
        }
    }
    
    @objc private func cellStyleChanged(_ notification: Notification) {
        if let newCellIdentifier = notification.object as? String {
            cellIdentifier = newCellIdentifier
            onDataUpdate?()
        }
    }
}
