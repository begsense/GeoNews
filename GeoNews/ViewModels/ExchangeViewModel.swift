//
//  ExchangeViewModel.swift
//  GeoNews
//
//  Created by M1 on 17.07.2024.
//

import Foundation

class ExchangeViewModel: ObservableObject {
    @Published var conversionRates: [String: Double] = [:]
    @Published var baseCurrency: String = "GEL" {
        didSet {
            fetchExchangeRates()
        }
    }
    @Published var targetCurrency: String = "USD" {
        didSet {
            filterConversionRates()
        }
    }
    
    init() {
        fetchExchangeRates()
    }
    
    func fetchExchangeRates() {
        let urlString = "https://v6.exchangerate-api.com/v6/b3c995272224c354797eadfb/latest/\(baseCurrency)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let exchangeRates = try JSONDecoder().decode(ExchangeRates.self, from: data)
                    DispatchQueue.main.async {
                        self.conversionRates = exchangeRates.conversionRates
                        self.filterConversionRates()
                    }
                } catch {
                    print("Error decoding: \(error)")
                }
            }
        }.resume()
    }
    
    func filterConversionRates() {
        guard let rate = conversionRates[targetCurrency] else { return }
        conversionRates = [targetCurrency: rate]
    }
}
