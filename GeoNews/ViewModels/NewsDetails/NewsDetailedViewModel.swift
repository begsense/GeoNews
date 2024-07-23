//
//  NewsDetailedViewModel.swift
//  GeoNews
//
//  Created by M1 on 11.07.2024.
//

import Foundation

class NewsDetailedViewModel {
    var selectedNews: News?
    
    //MARK: - Callbacks
    var didShare: (() -> Void)?
    var didUpdateLikes: (() -> Void)?
    var didUpdateReadLater: ((Bool) -> Void)?
    var didUpdateFavorite: ((Bool) -> Void)?
    
    //MARK: - Handlers
    func shareNews() {
        didShare?()
    }
    
    func toggleReadLater(completion: @escaping (Bool) -> Void) {
        guard let news = selectedNews else { return }
        let isReadLater = UserDefaultsManager.shared.toggleReadLater(news)
        completion(isReadLater)
    }
    
    func toggleFavorite(completion: @escaping (Bool) -> Void) {
        guard let news = selectedNews else { return }
        let isFavorite = UserDefaultsManager.shared.toggleFavorite(news)
        completion(isFavorite)
    }
    
    func toggleLikes(completion: @escaping (Bool) -> Void) {
        guard let newsTitle = selectedNews?.title else {
            completion(false)
            return
        }
        
        let isLiked = UserDefaultsManager.shared.isNewsLiked(newsTitle)
        
        if isLiked {
            NetworkService().updateLikes(for: newsTitle, increment: false) { [weak self] success in
                guard success else {
                    completion(false)
                    return
                }
                NetworkService().fetchData(filterBy: "title", equalTo: newsTitle) { updatedNewsItems in
                    if let updatedNews = updatedNewsItems.first {
                        self?.selectedNews = updatedNews
                        UserDefaultsManager.shared.removeLikedNews(newsTitle)
                        DispatchQueue.main.async {
                            completion(true)
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(false)
                        }
                    }
                }
            }
        } else {
            NetworkService().updateLikes(for: newsTitle, increment: true) { [weak self] success in
                guard success else {
                    completion(false)
                    return
                }
                NetworkService().fetchData(filterBy: "title", equalTo: newsTitle) { updatedNewsItems in
                    if let updatedNews = updatedNewsItems.first {
                        self?.selectedNews = updatedNews
                        UserDefaultsManager.shared.saveLikedNews(newsTitle)
                        DispatchQueue.main.async {
                            completion(true)
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(false)
                        }
                    }
                }
            }
        }
    }
}
