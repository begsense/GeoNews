//
//  LeaderboardsViewModel.swift
//  GeoNews
//
//  Created by M1 on 15.07.2024.
//

import Foundation
import FirebaseFirestore

class LeaderboardsViewModel: ObservableObject {
    @Published var users: [User] = []
    
    @Published var isLoading: Bool = false
    
    @Published var hasError: Bool = false
    
    init () {
        fetchUsers()
    }
    
    private var db = Firestore.firestore()
    
    func fetchUsers() {
        isLoading = true
        db.collection("users")
            .order(by: "score", descending: true)
            .getDocuments { [weak self] snapshot, error in
                self?.isLoading = false
                
                if error != nil {
                    self?.hasError = true
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    self?.hasError = true
                    return
                }
                
                self?.users = documents.compactMap { doc -> User? in
                    do {
                        let userData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                        let user = try JSONDecoder().decode(User.self, from: userData)
                        return user
                    } catch {
                        self?.hasError = true
                        return nil
                    }
                }
            }
    }
}
