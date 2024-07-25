//
//  ProfileViewModel.swift
//  GeoNews
//
//  Created by M1 on 13.07.2024.
//

import Foundation
import UIKit

class ProfileViewModel {
    var readLaterNews: [News] = []
    
    var favoriteNews: [News] = []
    
    var onProfileImageUpdated: (() -> Void)?
    
    var updateUserLabel: ((String) -> Void)?
    
    var onFavoritesUpdated: (() -> Void)?
    
    var onReadLaterUpdated: (() -> Void)?
    
    var hasError: ((Bool) -> Void)?
    
    init() {
        fetchReadLaterNews()
        fetchFavoriteNews()
    }

    func fetchReadLaterNews() {
        readLaterNews = UserDefaultsManager.shared.getReadLaterNews()
        onReadLaterUpdated?()
    }

    func fetchFavoriteNews() {
        favoriteNews = UserDefaultsManager.shared.getFavoriteNews()
        onFavoritesUpdated?()
    }

    func saveProfileImage(_ image: UIImage) {
        FileManagerHelper.shared.saveProfileImage(image)
        onProfileImageUpdated?()
    }

    func loadProfileImage() -> UIImage? {
        FileManagerHelper.shared.loadProfileImage()
    }
    
    func favoriteNews(at index: Int) -> News {
        favoriteNews[index]
    }
    
    func readLaterNews(at index: Int) -> News {
        readLaterNews[index]
    }
    
    func fetchUserHandler() {
        fetchUserData()
    }
    
    private func fetchUserData() {
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if error != nil {
                self.hasError?(true)
                  return
            }
            if let user = user {
                self.updateUserLabel?("Hello, \(user.username)\n Your Score Is: \(user.score)")
            }
        }
    }
}
