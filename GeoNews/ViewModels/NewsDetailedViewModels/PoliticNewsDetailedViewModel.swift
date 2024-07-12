//
//  PoliticNewsDetailedViewModel.swift
//  GeoNews
//
//  Created by M1 on 12.07.2024.
//

import Foundation

class PoliticNewsDetailedViewModel: NewsDetailedViewModelProtocol {
    var isLiked: Bool = false
    
    func updateLikes(completion: @escaping (Bool) -> Void) {
        //
    }
    
    
    var selectedNews: News?
    
    var shareAction: (() -> Void)?
    
    func shareNews() {
        shareAction?()
    }
}
