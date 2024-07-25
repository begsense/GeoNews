//
//  CustomButtonSUI.swift
//  GeoNews
//
//  Created by M1 on 24.07.2024.
//

import SwiftUI

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
