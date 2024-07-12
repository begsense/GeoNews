//
//  GeneralNewsDetailedViewModel.swift
//  GeoNews
//
//  Created by M1 on 11.07.2024.
//

import Foundation

class GeneralNewsDetailedViewModel: NewsDetailedViewModelProtocol {
    
    var selectedNews: News?
    
    var shareAction: (() -> Void)?
    
    var isLiked: Bool = false
    
    func shareNews() {
        shareAction?()
    }
    
    func updateLikes(completion: @escaping (Bool) -> Void) {
            guard !isLiked, let newsTitle = selectedNews?.title else {
                completion(false)
                return
            }
            
            NetworkService().updateLikes(for: newsTitle) { [weak self] _ in
                NetworkService().fetchData(filterBy: "title", equalTo: newsTitle) { updatedNewsItems in
                    if let updatedNews = updatedNewsItems.first {
                        self?.selectedNews = updatedNews
                        self?.isLiked = true 
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

protocol NewsDetailedViewModelProtocol {
    var isLiked: Bool { get }
    var selectedNews: News? { get }
    var shareAction: (() -> Void)? { get set }
    
    func shareNews()
    func updateLikes(completion: @escaping (Bool) -> Void)
}
