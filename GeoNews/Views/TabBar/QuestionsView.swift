//
//  QuestionsView.swift
//  GeoNews
//
//  Created by M1 on 14.07.2024.
//

import SwiftUI

struct QuestionsView: View {
    @StateObject var viewModel = QuizViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var progress: CGFloat = 0
    @State private var currentIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 15) {
            GeometryReader {
                let size = $0.size
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(.black.opacity(0.2))
                    
                    Rectangle()
                        .fill(Color(red: 138/255, green: 255/255, blue: 99/255))
                        .frame(width: progress * size.width, alignment: .leading)
                }
                .clipShape(Capsule())
            }
            .frame(width: 310, height: 20)
            .padding(.top, 5)
            
            // - Questions
            GeometryReader {
                let size = $0.size
                
                ForEach(viewModel.questions.indices, id: \.self) { index in
                    if currentIndex == index {
                        QuestionsView(viewModel.questions[currentIndex])
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    }
                }
                .padding(.vertical, 15)
            }
            
            Button {
                dismiss()
            } label: {
                Text("Done")
            }
            .padding(15)
            .frame(width: 310)
            .foregroundStyle(Color.white)
            .font(.custom("FiraGO-Regular", size: 18))
            .background(Color(red: 4/255, green: 123/255, blue: 128/255))
            .cornerRadius(20)
        }
        .foregroundStyle(Color.white)
        .padding(15)
        .background(Gradient(colors: [
            Color(red: 0/255, green: 62/255, blue: 99/255),
            Color(red: 0/255, green: 42/255, blue: 69/255)
        ]))
    }
    
    @ViewBuilder
    func QuestionsView(_ question: Quiz) -> some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(Color(red: 143/255, green: 158/255, blue: 179/255, opacity: 0.4))
    }
}
