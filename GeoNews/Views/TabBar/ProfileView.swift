//
//  ProfileView.swift
//  GeoNews
//
//  Created by M1 on 02.07.2024.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()

    var body: some View {
        VStack {
            Text("Read Later News")
            List(viewModel.readLaterNews, id: \.hashValue) { news in
                Text(news.title)
            }
            
            Text("Favorite News")
            List(viewModel.favoriteNews, id: \.hashValue) { news in
                Text(news.title)
            }
        }
        .onAppear {
            viewModel.fetchReadLaterNews()
            viewModel.fetchFavoriteNews()
        }
    }
}
