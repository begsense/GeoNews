//
//  News.swift
//  GeoNews
//
//  Created by M1 on 10.07.2024.
//

import Foundation

struct News: Decodable {
    let category: String
    let date: String
    let details: String
    let image: String
    let isfake: Bool
    let name: String
    let title: String
    let likes: Int
    
    var dateObject: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm, dd/MM/yyyy"
        return dateFormatter.date(from: date)
    }
}
