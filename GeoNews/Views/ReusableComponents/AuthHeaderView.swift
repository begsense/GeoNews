//
//  AuthHeaderView.swift
//  GeoNews
//
//  Created by M1 on 28.06.2024.
//

import SwiftUI

struct AuthHeaderView: View {
    var title: String
    var description: String
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 75, height: 75)
            
            Text(title)
                .fontWeight(.bold)
                .font(.title2)
            
            Text(description)
                .fontWeight(.light)
        }
       // .frame(height: 250)
        .background(Color(red: 47/255, green: 56/255, blue: 71/255))
        .foregroundStyle(Color(red: 231/255, green: 161/255, blue: 21/255))
        
    }
}

#Preview {
    AuthHeaderView(title: "Sign In", description: "Sign in to your account")
}
