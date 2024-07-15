//
//  NetworkService.swift
//  GeoNews
//
//  Created by M1 on 10.07.2024.
//

import Foundation
import FirebaseFirestore

class NetworkService {

    func fetchData(filterBy field: String? = nil, equalTo value: Any? = nil, completion: @escaping ([News]) -> Void) {
        let db = Firestore.firestore()
        var query: Query = db.collection("news")

        if let field = field, let value = value {
            query = query.whereField(field, isEqualTo: value)
        }

        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion([])
                return
            }

            let newsItems = querySnapshot?.documents.compactMap { document -> News? in
                do {
                    var news = try document.data(as: News.self)
                    return news
                } catch {
                    return nil
                }
            } ?? []

            completion(newsItems)
        }
    }

    func fetchData(filterByNames names: [String], completion: @escaping ([News]) -> Void) {
        let db = Firestore.firestore()
        var query: Query = db.collection("news")

        if !names.isEmpty {
            query = query.whereField("name", in: names)
        }

        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion([])
                return
            }

            let newsItems = querySnapshot?.documents.compactMap { document -> News? in
                do {
                    var news = try document.data(as: News.self)
                    return news
                } catch {
                    return nil
                }
            } ?? []

            completion(newsItems)
        }
    }

    func updateLikes(for newsTitle: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let newsRef = db.collection("news").whereField("title", isEqualTo: newsTitle)

        newsRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(false)
                return
            }

            guard let document = querySnapshot?.documents.first else {
                completion(false)
                return
            }

            let newsId = document.documentID
            let newsRefToUpdate = db.collection("news").document(newsId)

            newsRefToUpdate.updateData(["likes": FieldValue.increment(Int64(1))]) { error in
                if let error = error {
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }
}
