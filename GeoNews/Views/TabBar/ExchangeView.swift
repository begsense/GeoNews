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
                Picker("Select Exchange Type", selection: $viewModel.selectedExchangeType) {
                    ForEach(ExchangeViewModel.ExchangeType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if viewModel.selectedExchangeType == .currency {
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
                                viewModel.fetchExchangeRates()
                            }
                    }
                } else {
                    List {
                        ForEach(viewModel.cryptoRates.sorted(by: <), id: \.key) { key, value in
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
                        
                        TextField("Choose Target Currency", text: $viewModel.targetCrypto)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onSubmit {
                                viewModel.fetchExchangeRates()
                            }
                    }
                }
            }
            .navigationTitle("Exchange Rates")
        }
    }
}
