//
//  ProfileView.swift
//  GeoNews
//
//  Created by M1 on 02.07.2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var profileViewModel = ProfileViewModel()
   
    var body: some View {
        VStack {
            List {
                ForEach(["Imedi", "Rustavi2", "Formula"], id: \.self) { name in
                    HStack {
                        Text(name)
                        Spacer()
                        if profileViewModel.selectedNames.contains(name) {
                            Image(systemName: "checkmark")
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        profileViewModel.toggleNameSelection(name)
                    }
                }
            }
            Button(action: {
                profileViewModel.fetchFilteredNews()
            }) {
                Text("Fetch Filtered News")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .navigationTitle("Profile")
    }
}
