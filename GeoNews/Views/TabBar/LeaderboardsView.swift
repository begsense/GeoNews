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
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ForEach(viewModel.users, id: \.hashValue) { user in
                        HStack {
                            Text(user.username)
                                .font(.headline)
                            Spacer()
                            Text("\(user.score)")
                                .font(.subheadline)
                        }
                        .frame(maxWidth: 300, maxHeight: 50, alignment: .leading)
                        .foregroundStyle(Color.white)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue)
            .alert(isPresented: $viewModel.hasError) {
            Alert(
                title: Text("დაფიქსირდა შეცდომა"),
                message: Text("ვერ მოხდა ინფორმაციის წამოღება ბაზიდან, გთხოვთ სცადოთ ხელახლა"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
