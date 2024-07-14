//
//  QuizViewModel.swift
//  GeoNews
//
//  Created by M1 on 14.07.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class QuizViewModel: ObservableObject {
    @Published var questions: [Quiz] = []
    @Published var hasError: Bool = false
    @Published var errorMessage: String? = nil
    
    private var db = Firestore.firestore()
    
    @MainActor
    func fetchQuizzes() async {
        do {
            let snapshot = try await db.collection("quiz").getDocuments()
            self.questions = snapshot.documents.compactMap { document in
                try? document.data(as: Quiz.self)
            }
        } catch {
            self.hasError = true
            self.errorMessage = error.localizedDescription
        }
    }
    
    init() {
        Task {
            await fetchQuizzes()
        }
    }
}
