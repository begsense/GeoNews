//
//  QuizView.swift
//  GeoNews
//
//  Created by M1 on 02.07.2024.
//

import SwiftUI

struct QuizView: View {
    @State var startQuiz: Bool = false
    
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
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 125)
                    .scaledToFit()
                
                Text("Quiz შედგება 10 კითხვისგან")
                    .hAlign()
                
                Text("სავარაუდო 4 პასუხიდან სწორია 1")
                    .hAlign()
                
                Text("სწორი პასუხი ფასდება 10 ქულით")
                    .hAlign()
                
                Text("მაქსიმალური შეფასება 100 ქულა")
                    .hAlign()
                    .padding(.bottom, 15)
                
                Spacer()
                
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
        }
    }
}

extension View {
    func hAlign() -> some View {
        self
            .font(.custom("FiraGO-Regular", size: 16))
            .frame(maxWidth: 280, alignment: .leading)
            .padding(10)
    }
}

extension View {
    func CurrencyImageResize(name: String) -> some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .foregroundStyle(name == "equals" ? .white : Color(red: 4/255, green: 123/255, blue: 128/255))
    }
}


struct CustomButtonSUI: View {
    var title: String
    var onClick: () -> Void
    
    var body: some View {
        Button {
            onClick()
        } label: {
            Text(title)
                .padding(15)
                .frame(maxWidth: 310)
                .font(.custom("FiraGO-Regular", size: 18))
                .background(Color(red: 4/255, green: 123/255, blue: 128/255))
                .cornerRadius(20)
        }
    }
}
