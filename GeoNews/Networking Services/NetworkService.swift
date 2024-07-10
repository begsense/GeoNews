//
//  NetworkService.swift
//  GeoNews
//
//  Created by M1 on 10.07.2024.
//

import Foundation
import FirebaseFirestore

class NetworkService {
    func fetchData(forField field: String, equalTo value: Any, completion: @escaping ([News]) -> Void) {
        let db = Firestore.firestore()
        db.collection("news")
            .whereField(field, isEqualTo: value)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching documents: \(error)")
                    completion([])
                    return
                }
                
                // Extract documents from QuerySnapshot
                let newsItems = querySnapshot?.documents.compactMap { document -> News? in
                    let data = document.data()
                    let category = data["category"] as? String ?? ""
                    let date = data["date"] as? String ?? ""
                    let details = data["details"] as? String ?? ""
                    let image = data["image"] as? String ?? ""
                    let isfake = data["isfake"] as? Bool ?? false
                    let name = data["name"] as? String ?? ""
                    let title = data["title"] as? String ?? ""
                    
                    return News(category: category, date: date, details: details, image: image, isfake: isfake, name: name, title: title)
                } ?? []
                
                completion(newsItems)
            }
    }
}
