//
//  GeneralNewsViewModel.swift
//  GeoNews
//
//  Created by M1 on 10.07.2024.
//

import Foundation

class GeneralNewsViewModel {
    private var newsItems: [News] = []
    
    var numberOfItems: Int { newsItems.count }
    
    var onDataUpdate: (() -> Void)?
    
    var hasError: ((Bool) -> Void)?
    
    var onNewsSelected: ((News) -> Void)?
    
    var onMenuButtonTapped: (() -> Void)?
    
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
        return newsItems[index]
    }
    
    func handleMenuButtonTap() {
        onMenuButtonTapped?()
    }
    
    func navigateToNewsDetails(index: Int) {
        self.onNewsSelected?(newsItems[index])
    }
    
    private func getData() {
        NetworkService().fetchData { [weak self] newsItems in
            guard let self = self else { return }
            
            if newsItems.isEmpty {
                self.hasError?(true)
            } else {
                self.newsItems = newsItems.sorted {
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
