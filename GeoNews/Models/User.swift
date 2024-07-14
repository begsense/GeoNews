//
//  User.swift
//  GeoNews
//
//  Created by M1 on 07.07.2024.
//

import Foundation

struct User: Codable {
    let username: String
    let email: String
    let userUID: String?
    var score: Int
}
