//
//  CryptoExchangeRates.swift
//  GeoNews
//
//  Created by M1 on 18.07.2024.
//

import Foundation


struct CryptoExchangeRates: Decodable {
    let rates: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case rates = "GEL"
    }
}
