//
//  UserDefaultManager.swift
//  GeoNews
//
//  Created by M1 on 19.07.2024.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let likedNewsKey = "likedNews"
    private let readLaterKey = "readLaterNews"
    private let favoriteKey = "favoriteNews"
    
    private init() {}
    
    func saveLikedNews(_ newsTitle: String) {
        var likedNews = getLikedNews()
        likedNews.insert(newsTitle)
        UserDefaults.standard.set(Array(likedNews), forKey: likedNewsKey)
    }
    
    func removeLikedNews(_ newsTitle: String) {
        var likedNews = getLikedNews()
        likedNews.remove(newsTitle)
        UserDefaults.standard.set(Array(likedNews), forKey: likedNewsKey)
    }
    
    func isNewsLiked(_ newsTitle: String) -> Bool {
        let likedNews = getLikedNews()
        return likedNews.contains(newsTitle)
    }
    
    private func getLikedNews() -> Set<String> {
        let likedNews = UserDefaults.standard.stringArray(forKey: likedNewsKey) ?? []
        return Set(likedNews)
    }
    
    func toggleReadLater(_ news: News) -> Bool {
        var readLaterNews = getReadLaterNews()
        if let index = readLaterNews.firstIndex(where: { $0.title == news.title }) {
            readLaterNews.remove(at: index)
        } else {
            readLaterNews.append(news)
        }
        saveReadLaterNews(readLaterNews)
        return readLaterNews.contains(where: { $0.title == news.title })
    }
    
    func toggleFavorite(_ news: News) -> Bool {
        var favoriteNews = getFavoriteNews()
        if let index = favoriteNews.firstIndex(where: { $0.title == news.title }) {
            favoriteNews.remove(at: index)
        } else {
            favoriteNews.append(news)
        }
        saveFavoriteNews(favoriteNews)
        return favoriteNews.contains(where: { $0.title == news.title })
    }
    
    func getReadLaterNews() -> [News] {
        guard let data = UserDefaults.standard.data(forKey: readLaterKey),
              let news = try? JSONDecoder().decode([News].self, from: data) else {
            return []
        }
        return news
    }
    
    func getFavoriteNews() -> [News] {
        guard let data = UserDefaults.standard.data(forKey: favoriteKey),
              let news = try? JSONDecoder().decode([News].self, from: data) else {
            return []
        }
        return news
    }
    
    private func saveReadLaterNews(_ news: [News]) {
        if let data = try? JSONEncoder().encode(news) {
            UserDefaults.standard.set(data, forKey: readLaterKey)
        }
    }
    
    private func saveFavoriteNews(_ news: [News]) {
        if let data = try? JSONEncoder().encode(news) {
            UserDefaults.standard.set(data, forKey: favoriteKey)
        }
    }
}
