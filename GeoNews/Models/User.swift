//
//  User.swift
//  GeoNews
//
//  Created by M1 on 07.07.2024.
//

import Foundation

struct User: Decodable, Hashable {
    let username: String
    let email: String
    var score: Int
}
