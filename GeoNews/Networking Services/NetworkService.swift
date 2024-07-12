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
                print("Error fetching documents: \(error)")
                completion([])
                return
            }
            
            let newsItems = querySnapshot?.documents.compactMap { document -> News? in
                let data = document.data()
                let id = document.documentID
                let category = data["category"] as? String ?? ""
                let date = data["date"] as? String ?? ""
                let details = data["details"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                let isfake = data["isfake"] as? Bool ?? false
                let name = data["name"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                let likes = data["likes"] as? Int ?? 0
                
                return News(id: id, category: category, date: date, details: details, image: image, isfake: isfake, name: name, title: title, likes: likes)
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
