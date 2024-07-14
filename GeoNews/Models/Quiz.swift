//
//  Quiz.swift
//  GeoNews
//
//  Created by M1 on 14.07.2024.
//

import Foundation
import FirebaseFirestoreSwift

struct Quiz: Identifiable, Codable {
    @DocumentID var id: String?
    let answer: String
    let options: [String]
    let question: String
    
    var tappedAnswer: String? = nil
}
