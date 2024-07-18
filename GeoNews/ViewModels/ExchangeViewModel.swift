//
//  ExchangeViewModel.swift
//  GeoNews
//
//  Created by M1 on 17.07.2024.
//

import Foundation

class ExchangeViewModel: ObservableObject {
    @Published var conversionRates: [String: Double] = [:]
    @Published var cryptoRates: [String: Double] = [:]
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
    @Published var selectedExchangeType: ExchangeType = .currency {
        didSet {
            fetchExchangeRates()
        }
    }
    @Published var targetCrypto: String = "bitcoin" {
        didSet {
            fetchExchangeRates()
        }
    }
    
    enum ExchangeType: String, CaseIterable, Identifiable {
        case currency = "Currency"
        case crypto = "Cryptocurrency"
        
        var id: String { self.rawValue }
    }
    
    let supportedCryptos = ["bitcoin", "ethereum", "ripple", "litecoin"]
    
    init() {
        fetchExchangeRates()
    }
    
    func fetchExchangeRates() {
        switch selectedExchangeType {
        case .currency:
            let urlString = "https://v6.exchangerate-api.com/v6/b3c995272224c354797eadfb/latest/\(baseCurrency)"
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let exchangeRates = try JSONDecoder().decode(CurrencyExchangeRates.self, from: data)
                        DispatchQueue.main.async {
                            self.conversionRates = exchangeRates.conversionRates
                            self.filterConversionRates()
                        }
                    } catch {
                        print("Error decoding currency exchange rates: \(error)")
                    }
                } else if let error = error {
                    print("Network error fetching currency exchange rates: \(error)")
                }
            }.resume()
            
        case .crypto:
            let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(targetCrypto)&vs_currencies=\(baseCurrency)&x_cg_demo_api_key=CG-NeuCxE3hLPNpQc12y6sqWWUA"
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let cryptoRates = try JSONDecoder().decode(CryptoRates.self, from: data)
                        DispatchQueue.main.async {
                            switch self.targetCrypto {
                            case "bitcoin":
                                if let bitcoinRates = cryptoRates.bitcoin {
                                    self.cryptoRates = bitcoinRates
                                } else {
                                    self.cryptoRates = [:]
                                }
                            case "ethereum":
                                if let ethereumRates = cryptoRates.ethereum {
                                    self.cryptoRates = ethereumRates
                                } else {
                                    self.cryptoRates = [:]
                                }
                            case "ripple":
                                if let rippleRates = cryptoRates.ripple {
                                    self.cryptoRates = rippleRates
                                } else {
                                    self.cryptoRates = [:]
                                }
                            case "litecoin":
                                if let litecoinRates = cryptoRates.litecoin {
                                    self.cryptoRates = litecoinRates
                                } else {
                                    self.cryptoRates = [:]
                                }
                            default:
                                self.cryptoRates = [:]
                            }
                        }
                    } catch {
                        print("Error decoding crypto exchange rates: \(error)")
                    }
                }
            }.resume()
        }
    }

    
    func filterConversionRates() {
        guard let rate = conversionRates[targetCurrency] else { return }
        conversionRates = [targetCurrency: rate]
    }
}
