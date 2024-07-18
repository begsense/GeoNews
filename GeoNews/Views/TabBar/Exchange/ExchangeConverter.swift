////
////  ExchangeConverter.swift
////  GeoNews
////
////  Created by M1 on 18.07.2024.
////
//
//import SwiftUI
//
//struct ExchangeConverter: View {
//    var currency: String
//    var rate: Double
//    @ObservedObject var viewModel: ExchangeViewModel
//    
//    var body: some View {
//        HStack {
//            Text(currency)
//            Spacer()
//            Text(String(format: "%.4f", rate))
//            Spacer()
//            if viewModel.selectedExchangeType == .currency {
//                Button(action: {
//                    if let amount = Double(viewModel.moneyInput) {
//                        viewModel.result = amount * rate
//                    } else {
//                        viewModel.result = 0.0
//                    }
//                }) {
//                    Image(systemName: "arrow.right.circle")
//                        .foregroundColor(.blue)
//                        .font(.title)
//                }
//            } else {
//                Button(action: {
//                    if let amount = Double(viewModel.moneyInput) {
//                        viewModel.result = amount * rate
//                    } else {
//                        viewModel.result = 0.0
//                    }
//                }) {
//                    Image(systemName: "arrow.right.circle")
//                        .foregroundColor(.blue)
//                        .font(.title)
//                }
//            }
//        }
//        .padding()
//    }
//}
