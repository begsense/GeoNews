//
//  RegisterUserRequest.swift
//  GeoNews
//
//  Created by M1 on 02.07.2024.
//

import Foundation

struct RegisterUserRequest: Encodable {
    let username: String
    let email: String
    let password: String
    let score: Int
}
