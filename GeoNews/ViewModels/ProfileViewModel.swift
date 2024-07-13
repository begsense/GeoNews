//
//  ProfileViewModel.swift
//  GeoNews
//
//  Created by M1 on 13.07.2024.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var selectedNames: [String] = [] {
        didSet {
            fetchFilteredNews()
        }
    }
    
    var onDataUpdate: (([News]) -> Void)?
    
    func toggleNameSelection(_ name: String) {
        if selectedNames.contains(name) {
            selectedNames.removeAll { $0 == name }
        } else {
            selectedNames.append(name)
        }
    }
    
    func fetchFilteredNews() {
        
    }
}
