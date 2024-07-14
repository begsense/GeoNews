//
//  ScoreCardView.swift
//  GeoNews
//
//  Created by M1 on 14.07.2024.
//

import SwiftUI

struct ScoreCardView: View {
    var score: Int
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = QuizViewModel()
    var onDismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            Text("ტესტის შედეგი")
            
            VStack(spacing: 15) {
                Text(score > 10 ? "გილოცავ! შენი ქულაა " : "კიდევ სცადე! შენი ქულაა ")
                
                Text("\(score)")
                    .font(.custom("FiraGO-Regular", size: 24))
                
                Image(score > 10 ? "medal" : "worry")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 220)
                    .foregroundStyle(score > 20 ?
                                     Color(red: 205/255, green: 149/255, blue: 22/255)
                                     : Color(red: 224/255, green: 230/255, blue: 232/255))
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity, alignment: .center)
            .background {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(red: 8/255, green: 40/255, blue: 67/255).opacity(0.5))
            }
            
            Spacer()
            
            CustomButtonSUI(title: "Back to Home") {
                viewModel.updateScore(newScore: score) { success, error in
                    onDismiss()
                    dismiss()
                }
            }
        }
        .foregroundStyle(Color.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .font(.custom("FiraGO-Regular", size: 20))
        .multilineTextAlignment(.center)
        .background(Gradient(colors: [
            Color(red: 0/255, green: 62/255, blue: 99/255),
            Color(red: 0/255, green: 42/255, blue: 69/255)
        ]))
    }
}
