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
                .frame(width: 100, height: 125)
            
            Text(title)
                .font(.custom("FiraGO-Regular", size: 18))
            
            Text(description)
                .font(.custom("FiraGO-Regular", size: 16))
        }
        .background(Color(red: 47/255, green: 56/255, blue: 71/255))
        .foregroundStyle(Color(red: 231/255, green: 161/255, blue: 21/255))
        
    }
}
