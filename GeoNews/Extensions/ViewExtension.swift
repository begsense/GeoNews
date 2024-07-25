//
//  ViewExtension.swift
//  GeoNews
//
//  Created by M1 on 24.07.2024.
//

import SwiftUI

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
            .foregroundStyle(name == "equals" ? .white : Color(red: 138/255, green: 255/255, blue: 99/255))
    }
}
