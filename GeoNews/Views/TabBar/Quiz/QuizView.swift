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
            
            CustomButtonSUI(title: "Start") {
                startQuiz.toggle()
            }
            
            Spacer()
                .frame(height: 100)
        }
        .foregroundStyle(Color.white)
        .frame(maxWidth: .infinity * 0.75, maxHeight: .infinity)
        .background(Gradient(colors: [
            Color(red: 0/255, green: 62/255, blue: 99/255),
            Color(red: 0/255, green: 42/255, blue: 69/255)
        ]))
        .fullScreenCover(isPresented: $startQuiz, content: {
            QuizQuestionsView()
        })
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
