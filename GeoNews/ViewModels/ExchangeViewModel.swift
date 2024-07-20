//
//  ExchangeViewModel.swift
//  GeoNews
//
//  Created by M1 on 18.07.2024.
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
            fetchExchangeRates()
        }
    }
    @Published var selectedExchangeType: ExchangeType = .currency {
        didSet {
            fetchExchangeRates()
        }
    }
    @Published var targetCrypto: String = "BTC" {
        didSet {
            fetchExchangeRates()
        }
    }
    @Published var moneyInput: String = "1" {
        didSet {
            if moneyInput.count > characterLimit && oldValue.count <= characterLimit {
                moneyInput = oldValue
            }
        }
    }
    @Published var result: Double = 0.0

    private var characterLimit: Int = 7
    
    var formattedResult: String {
        let formattedString = String(format: "%.4f", result)
        if formattedString.contains(".") {
            let components = formattedString.split(separator: ".")
            if components.count > 1, !components[1].allSatisfy({ $0 == "0" }) {
                return formattedString
            }
        }
        return String(format: "%.0f", result)
    }

    enum ExchangeType: String, CaseIterable, Identifiable {
        case currency = "Currency"
        case crypto = "Cryptocurrency"
        
        var id: String { self.rawValue }
    }

    init() {
        fetchExchangeRates()
    }

    func fetchExchangeRates() {
        var urlString = ""
        switch selectedExchangeType {
        case .currency:
            urlString = "https://v6.exchangerate-api.com/v6/b3c995272224c354797eadfb/latest/\(baseCurrency)"
        case .crypto:
            urlString = "https://min-api.cryptocompare.com/data/pricemulti?fsyms=\(targetCrypto)&tsyms=\(baseCurrency)&api_key=ff40c731679562a0a9fb0274336e8ff36378a250198b2b6842aba8b12a7147f3"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                
                switch self.selectedExchangeType {
                case .currency:
                    do {
                        let exchangeRates = try JSONDecoder().decode(CurrencyExchangeRates.self, from: data)
                        DispatchQueue.main.async {
                            self.conversionRates = exchangeRates.conversionRates
                            self.calculateResult()
                        }
                    } catch {
                        print("Error decoding currency exchange rates: \(error)")
                    }
                    
                case .crypto:
                    do {
                        let cryptoRates = try JSONDecoder().decode([String: [String: Double]].self, from: data)
                        DispatchQueue.main.async {
                            if let rates = cryptoRates[self.targetCrypto], let rate = rates[self.baseCurrency] {
                                self.result = Double(self.moneyInput)! * rate
                            }
                        }
                    } catch {
                        print("Error decoding crypto exchange rates: \(error)")
                    }
                }
            }
        }.resume()
    }


    private func calculateResult() {
        guard let inputValue = Double(moneyInput) else {
            result = 0.0
            return
        }
        
        if let rate = conversionRates[targetCurrency] {
            result = inputValue * rate
        }
    }
}
