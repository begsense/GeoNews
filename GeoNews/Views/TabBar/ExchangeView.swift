//
//  ExchangeView.swift
//  GeoNews
//
//  Created by M1 on 17.07.2024.
//

import SwiftUI

struct ExchangeView: View {
    @StateObject var viewModel: ExchangeViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.conversionRates.sorted(by: <), id: \.key) { key, value in
                        HStack {
                            Text(key)
                            Spacer()
                            Text(String(format: "%.4f", value))
                        }
                    }
                }
                
                HStack {
                    TextField("Choose Base Currency", text: $viewModel.baseCurrency)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            viewModel.fetchExchangeRates()
                        }
                    
                    TextField("Choose Target Currency", text: $viewModel.targetCurrency)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            viewModel.filterConversionRates()
                        }
                }
            }
            .navigationTitle("Exchange Rates")
        }
    }
}
