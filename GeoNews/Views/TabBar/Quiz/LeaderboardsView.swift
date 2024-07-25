//
//  LeaderboardsView.swift
//  GeoNews
//
//  Created by M1 on 02.07.2024.
//

import SwiftUI

struct LeaderboardsView: View {
    @StateObject var viewModel: LeaderboardsViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Rank")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Text("Username")
                    .frame(width: 140, alignment: .leading)
                
                Spacer()
                    .frame(width: 15)
                
                Text("Score")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .font(.custom("FiraGO-Regular", size: 18))
            .foregroundStyle(Color.white)
            
            ForEach(viewModel.users.indices, id: \.self) { index in
                let user = viewModel.users[index]
                HStack {
                    Text("\(index + 1)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Text(user.username)
                        .frame(width: 140, alignment: .leading)
                        .padding(.leading, 15)
                    
                    Spacer()
                        .frame(width: 15)
                    
                    Text("\(user.score)")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .font(.custom("FiraGO-Regular", size: 16))
                .padding(.horizontal)
                .foregroundStyle(Color.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.clear)
            .alert(isPresented: $viewModel.hasError) {
                Alert(
                    title: Text("დაფიქსირდა შეცდომა"),
                    message: Text("ვერ მოხდა ინფორმაციის წამოღება ბაზიდან, გთხოვთ სცადოთ ხელახლა"),
                    dismissButton: .default(Text("OK"))
                )}
        }
        .padding(25)
        .background(Color(red: 8/255, green: 40/255, blue: 67/255))
    }
}
