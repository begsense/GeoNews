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

    func saveProfileImage(_ image: UIImage) {
        FileManagerHelper.shared.saveProfileImage(image)
        onProfileImageUpdated?()
    }

    func loadProfileImage() -> UIImage? {
        return FileManagerHelper.shared.loadProfileImage()
    }
}
