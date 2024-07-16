//
//  LeaderboardItemView.swift
//  GeoNews
//
//  Created by M1 on 16.07.2024.
//

import SwiftUI

struct LeaderboardItemView: View {
    var rank: Int
    var username: String
    var score: Int
    
    var body: some View {
        HStack {
            Text("\(rank)")
                .foregroundColor(.white)
                .font(.headline)
                .frame(width: 50)
            
            Text(username)
                .foregroundColor(.white)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("\(score)")
                .foregroundColor(.white)
                .font(.headline)
                .frame(width: 50)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
}
