//
//  QuizView.swift
//  GeoNews
//
//  Created by M1 on 02.07.2024.
//

import SwiftUI

struct QuizView: View {
    @State var startQuiz: Bool = false
    @State var showLeaderboard: Bool = false
    
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
                Spacer()
                
                Image("logo")
                    .resizable()
                    .frame(width: 150, height: 180)
                    .scaledToFit()
                
                VStack {
                    Text("Quiz შედგება 10 კითხვისგან")
                        .hAlign()
                    
                    Text("სავარაუდო 4 პასუხიდან სწორია 1")
                        .hAlign()
                    
                    Text("სწორი პასუხი ფასდება 10 ქულით")
                        .hAlign()
                    
                    Text("მაქსიმალური შეფასება 100 ქულა")
                        .hAlign()
                }
                .padding(20)
                .background(RoundedRectangle(cornerRadius: 25, style: .continuous).fill(Color(red: 8/255, green: 40/255, blue: 67/255)))
                
                Spacer()
                    .frame(height: 100)
                
                Button {
                    showLeaderboard.toggle()
                } label: {
                    Text("See Leaderboard")
                        .font(.custom("FiraGO-Regular", size: 18))
                        .foregroundStyle(Color(red: 138/255, green: 255/255, blue: 99/255, opacity: 0.85))
                }
                
                Spacer()
                    .frame(height: 50)
                
                CustomButtonSUI(title: "Start") {
                    startQuiz.toggle()
                }
                
                Spacer()
                    .frame(height: 15)
            }
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity * 0.75)
            .fullScreenCover(isPresented: $startQuiz, content: {
                QuizQuestionsView()
            })
            .sheet(isPresented: $showLeaderboard, content: {
                LeaderboardsView(viewModel: LeaderboardsViewModel())
            })
        }
    }
}
