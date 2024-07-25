//
//  ExchangeViewModel.swift
//  GeoNews
//
//  Created by M1 on 18.07.2024.
//

import Foundation

class ExchangeViewModel: ObservableObject {
    //MARK: - Properties
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
    
    private var characterLimit: Int = 9
    
    var availableCurrencies = ["GEL", "USD", "EUR", "GBP", "CAD", "AUD", "JPY", "INR", "NZD", "AED",
                               "AFN", "ALL", "AMD", "ANG", "AOA", "ARS", "AWG", "AZN", "BAM", "BBD",
                               "BDT", "BGN", "BHD", "BIF", "BMD", "BND", "BOB", "BRL", "BSD", "BTN",
                               "BWP", "BYN", "BZD", "CDF", "CHF", "CLP", "CNY", "COP", "CRC", "CUP",
                               "CVE", "CZK", "DJF", "DKK", "DOP", "DZD", "EGP", "ERN", "ETB", "FJD",
                               "FKP", "FOK", "GGP", "GHS", "GIP", "GMD", "GNF", "GTQ", "GYD", "HKD",
                               "HNL", "HRK", "HTG", "HUF", "IDR", "ILS", "IMP", "IQD", "IRR", "ISK",
                               "JEP", "JMD", "JOD", "KES", "KGS", "KHR", "KID", "KMF", "KRW", "KWD",
                               "KYD", "KZT", "LAK", "LBP", "LKR", "LRD", "LSL", "LYD", "MAD", "MDL",
                               "MGA", "MKD", "MMK", "MNT", "MOP", "MRU", "MUR", "MVR", "MWK", "MXN",
                               "MYR", "MZN", "NAD", "NGN", "NIO", "NOK", "NPR", "OMR", "PAB", "PEN",
                               "PGK", "PHP", "PKR", "PLN", "PYG", "QAR", "RON", "RSD", "RUB", "RWF",
                               "SAR", "SBD", "SCR", "SDG", "SEK", "SGD", "SHP", "SLE", "SLL", "SOS",
                               "SRD", "SSP", "STN", "SYP", "SZL", "THB", "TJS", "TMT", "TND", "TOP",
                               "TRY", "TTD", "TVD", "TWD", "TZS", "UAH", "UGX", "UYU", "UZS", "VES",
                               "VND", "VUV", "WST", "XAF", "XCD", "XPF", "YER", "ZAR", "ZMW", "ZWL"]
    
    var availableCryptos = ["BTC", "ETH", "LTC", "XRP", "BCH", "EOS", "XLM", "ADA", "TRX", "NEO",
                            "MIOTA", "XEM", "DASH", "ETC", "XMR", "ZEC", "VEN", "BNB", "OMG", "QTUM",
                            "BTG", "LSK", "ICX", "DGD", "STEEM", "BCN", "SC", "BTS", "STRAT", "WAVES",
                            "DOGE", "MKR", "ZRX", "DGB", "REP", "BAT", "IOST", "ZIL", "AE", "XVG",
                            "NPXS", "GNT", "SNT", "WTC", "RHOC", "KNC", "AION", "DCN", "QASH", "CNX",
                            "ARK", "LINK", "PIVX", "WAN", "HOT", "POLY", "PAY", "ELF", "POWR",
                            "MAID", "GAS", "NANO", "DENT", "FUN", "KMD", "MONA", "SYS", "LRC",
                            "ZEN", "FCT", "GXS", "SUB", "QSP", "ENG", "CVC", "PART", "EDO",
                            "MANA", "RLC", "STORM", "REQ", "NXT", "POE", "MTL", "CMT", "TNB", "BLZ",
                            "STORJ", "DRGN", "PPT", "QKC", "BRD", "LOOM", "NXS", "BNT", "THETA", "GRS",
                            "MITH", "DATA", "CND", "BAY", "GO", "NCASH", "STQ", "VTC", "POT", "GBYTE",
                            "BTM", "UTK", "CLOAK", "SKY", "AURA", "UBQ", "SMART", "EXP", "DCT", "NLG",
                            "NAV", "SAN", "NEBL", "BTCD", "XBY", "DMD", "IOP", "SLR", "XAS", "EMC2"]
    
    var availableFiatCurrencies = ["GEL", "USD", "EUR", "JPY", "GBP", "AUD", "CAD", "CHF", "CNY", "HKD",
                                   "NZD", "SEK", "KRW", "SGD", "NOK", "MXN", "INR", "RUB", "ZAR", "TRY",
                                   "AED", "DKK", "PLN", "THB", "IDR", "HUF", "CZK", "ILS", "CLP", "PHP",
                                   "COP", "MYR", "RON", "BRL"]
    
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
    
    //MARK: - Functions
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
                        print("Error decoding currency rates")
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
                        print("Error decoding crypto rates")
                    }
                }
            }
        }.resume()
    }
    
    func calculateResult() {
        guard let inputValue = Double(moneyInput) else {
            result = 0.0
            return
        }
        
        if let rate = conversionRates[targetCurrency] {
            result = inputValue * rate
        }
    }
}
