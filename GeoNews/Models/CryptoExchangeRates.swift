//
//  CryptoExchangeRates.swift
//  GeoNews
//
//  Created by M1 on 18.07.2024.
//

import Foundation

struct CryptoRates: Decodable {
    let bitcoin: [String: Double]?
    let ethereum: [String: Double]?
    let ripple: [String: Double]?
    let litecoin: [String: Double]?

    enum CodingKeys: String, CodingKey {
        case bitcoin = "bitcoin"
        case ethereum = "ethereum"
        case ripple = "ripple"
        case litecoin = "litecoin"
    }
}
