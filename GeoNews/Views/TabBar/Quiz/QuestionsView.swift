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
    @State private var selectedAnswer: String = ""
    @State private var showResults: Bool = false
    
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
            
            GeometryReader { _ in
                ForEach(viewModel.questions.indices, id: \.self) { index in
                    if viewModel.currentIndex == index {
                        QuestionsView(viewModel.questions[viewModel.currentIndex])
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    }
                }
                .padding(.vertical, 15)
            }
            .padding(.horizontal, -15)
            
            CustomButtonSUI(title: viewModel.currentIndex == (viewModel.questions.count - 1) ? "Finish" : "Next Question") {
                if viewModel.currentIndex == (viewModel.questions.count - 1) {
                    showResults.toggle()
                } else {
                    withAnimation(.easeInOut) {
                        viewModel.moveToNextQuestion()
                        selectedAnswer = ""
                        progress = CGFloat(viewModel.currentIndex) / CGFloat(viewModel.questions.count - 1)
                    }
                }
            }
        }
        .foregroundStyle(Color.white)
        .padding(15)
        .background(Gradient(colors: [
            Color(red: 0/255, green: 62/255, blue: 99/255),
            Color(red: 0/255, green: 42/255, blue: 69/255)
        ]))
        .fullScreenCover(isPresented: $showResults, content: {
            ScoreCardView(score: viewModel.score) {
                dismiss()
            }
        })
    }
    
    @ViewBuilder
    func QuestionsView(_ question: Quiz) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("კითხვა \(viewModel.currentIndex + 1)/\(viewModel.questions.count)")
                .font(.custom("FiraGO-Regular", size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(question.question)
                .font(.custom("FiraGO-Regular", size: 20))
            
            VStack(spacing: 12) {
                ForEach(question.options, id: \.self) { option in
                    OptionView(option, getColor(for: option, in: question))
                        .onTapGesture {
                            selectAnswer(option, in: question)
                        }
                }
            }
            .padding(.vertical, 10)
        }
        .padding(15)
        .foregroundStyle(Color.white)
        .frame(maxWidth: .infinity, alignment: .center)
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(red: 8/255, green: 40/255, blue: 67/255))
        }
        .padding(.horizontal, 15)
    }
    
    func getColor(for option: String, in question: Quiz) -> Color {
        if selectedAnswer == "" {
            return .white
        } else if option == question.answer {
            return .green
        } else if option == selectedAnswer {
            return .red
        } else {
            return .white
        }
    }
    
    func selectAnswer(_ option: String, in question: Quiz) {
        if selectedAnswer == "" {
            selectedAnswer = option
            if option == question.answer {
                viewModel.score += 10
            }
        }
    }
    
    @ViewBuilder
    func OptionView(_ option: String, _ tint: Color) -> some View {
        Text(option)
            .foregroundStyle(tint)
            .padding(.horizontal, 15)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(red: 8/255, green: 40/255, blue: 67/255).opacity(0.5))
                    .background {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(tint, lineWidth: 2)
                    }
            }
    }
}
