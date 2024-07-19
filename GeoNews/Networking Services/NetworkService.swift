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

        query.getDocuments { (querySnapshot, _) in
            let newsItems = querySnapshot?.documents.compactMap { document -> News? in
                do {
                    let news = try document.data(as: News.self)
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

        query.getDocuments { (querySnapshot, _) in
            let newsItems = querySnapshot?.documents.compactMap { document -> News? in
                do {
                    let news = try document.data(as: News.self)
                    return news
                } catch {
                    return nil
                }
            } ?? []

            completion(newsItems)
        }
    }


    func updateLikes(for newsTitle: String, increment: Bool, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let newsRef = db.collection("news").whereField("title", isEqualTo: newsTitle)

        newsRef.getDocuments { (querySnapshot, error) in
            if error != nil {
                completion(false)
                return
            }

            guard let document = querySnapshot?.documents.first else {
                completion(false)
                return
            }

            let newsId = document.documentID
            let newsRefToUpdate = db.collection("news").document(newsId)

            let incrementValue = increment ? Int64(1) : Int64(-1)
            newsRefToUpdate.updateData(["likes": FieldValue.increment(incrementValue)]) { error in
                if error != nil {
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }
}
