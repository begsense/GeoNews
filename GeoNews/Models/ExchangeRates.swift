//
//  ExchangeRates.swift
//  GeoNews
//
//  Created by M1 on 17.07.2024.
//

import Foundation

struct ExchangeRates: Decodable {
    let conversionRates: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case conversionRates = "conversion_rates"
    }
}
