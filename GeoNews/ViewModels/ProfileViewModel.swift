//
//  ProfileViewModel.swift
//  GeoNews
//
//  Created by M1 on 13.07.2024.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var readLaterNews: [News] = []
    @Published var favoriteNews: [News] = []

    init() {
        fetchReadLaterNews()
        fetchFavoriteNews()
    }

    func fetchReadLaterNews() {
        readLaterNews = UserDefaultsManager.shared.getReadLaterNews()
    }

    func fetchFavoriteNews() {
        favoriteNews = UserDefaultsManager.shared.getFavoriteNews()
    }
}
