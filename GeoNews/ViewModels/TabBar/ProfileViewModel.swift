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
        return FileManagerHelper.shared.loadProfileImage()
    }
    
    func fetchUserData() {
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if error != nil {
                  return
            }
            if let user = user {
                self.updateUserLabel?("Hello, \(user.username)\n Your Score Is: \(user.score)")
            }
        }
    }
    
    func favoriteNews(at index: Int) -> News {
        return favoriteNews[index]
    }
    
    func readLaterNews(at index: Int) -> News {
        return readLaterNews[index]
    }
}
