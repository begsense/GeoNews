//
//  ExchangeView.swift
//  GeoNews
//
//  Created by M1 on 18.07.2024.
//

import SwiftUI

struct ExchangeView: View {
    @StateObject var viewModel: ExchangeViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 0/255, green: 62/255, blue: 99/255),
                Color(red: 0/255, green: 42/255, blue: 69/255)
            ]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea(.all, edges: .top)
            
            Color(red: 0/255, green: 64/255, blue: 99/255)
                .frame(maxWidth: .infinity)
                .ignoresSafeArea(.all, edges: .bottom)
                .zIndex(-1)
            
            VStack {
                if viewModel.selectedExchangeType == .currency {
                    Text("Currency Converter")
                        .foregroundColor(.white)
                        .font(.title)
                    
                    Spacer()
                    
                    currencyExchangeResult
                    
                    Spacer()
                    
                    currencyExchangeInputs
                } else {
                    Text("Crypto Converter")
                        .foregroundColor(.white)
                        .font(.title)
                    
                    Spacer()
                    
                    cryptoExchangeResult
                    
                    Spacer()
                    
                    cryptoExchangeInputs
                }
                
                Picker("Select Exchange Type", selection: $viewModel.selectedExchangeType) {
                    ForEach(ExchangeViewModel.ExchangeType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                            .tag(type)
                            .foregroundColor(.white)
                            .font(.custom("FiraGO-Regular", size: 20))
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 300, height: 100, alignment: .center)
            }
            .padding()
        }
        .font(.custom("FiraGO-Regular", size: 18))
    }
    
    private var currencyExchangeResult: some View {
        VStack {
            HStack {
                Text(viewModel.moneyInput)
                
                CurrencyImageResize(name: viewModel.baseCurrency)
                
                CurrencyImageResize(name: "equals")
            }
            
            HStack {
                Text(String(format: "%.4f", viewModel.result))
                
                CurrencyImageResize(name: viewModel.targetCurrency)
            }
        }
        .font(.custom("FiraGO-Regular", size: 65))
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(Color(red: 8/255, green: 40/255, blue: 67/255).opacity(0.85))
            .frame(maxWidth: .infinity))
        
    }
    
    private var currencyExchangeInputs: some View {
        HStack {
            TextField("1", text: $viewModel.moneyInput)
                .padding(8)
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .textCase(.uppercase)
            
            TextField("GEL", text: $viewModel.baseCurrency)
                .padding(8)
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .textCase(.uppercase)
                .onSubmit {
                    viewModel.fetchExchangeRates()
                }
            
            TextField("USD", text: $viewModel.targetCurrency)
                .padding(8)
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .textCase(.uppercase)
                .onSubmit {
                    viewModel.fetchExchangeRates()
                }
        }
        .padding()
    }
    
    private var cryptoExchangeResult: some View {
        VStack {
            HStack {
                Text(viewModel.moneyInput)
                
                CurrencyImageResize(name: viewModel.baseCurrency)
                
                CurrencyImageResize(name: "equals")
            }
            
            HStack {
                Text(String(format: "%.3f", viewModel.result))
                
                CurrencyImageResize(name: viewModel.targetCrypto)
            }
        }
        .font(.custom("FiraGO-Regular", size: 65))
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(Color(red: 8/255, green: 40/255, blue: 67/255).opacity(0.85))
            .frame(maxWidth: .infinity))
        
    }
    
    private var cryptoExchangeInputs: some View {
        HStack {
            TextField("1", text: $viewModel.moneyInput)
                .padding(8)
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .textCase(.uppercase)
            
            TextField("GEL", text: $viewModel.baseCurrency)
                .padding(8)
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .textCase(.uppercase)
                .onSubmit {
                    viewModel.fetchExchangeRates()
                }
            
            TextField("BTC", text: $viewModel.targetCrypto)
                .padding(8)
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .textCase(.uppercase)
                .onSubmit {
                    viewModel.fetchExchangeRates()
                }
        }
        .padding()
    }
}
