//
//  Quiz.swift
//  GeoNews
//
//  Created by M1 on 14.07.2024.
//

import Foundation

struct Quiz: Decodable {
    let answer: String
    let options: [String]
    let question: String
}
