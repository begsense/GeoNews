//
//  QuizViewModel.swift
//  GeoNews
//
//  Created by M1 on 14.07.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class QuizViewModel: ObservableObject {
    @Published var questions: [Quiz] = []
    @Published var currentIndex: Int = 0
    @Published var score: Int = 0
    @Published var hasError: Bool = false
    
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
            //Error handling გასაკეთებელი მაქ
        }
    }
    
    func moveToNextQuestion() {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
        }
    }
    
    func updateScore(newScore: Int, completion: @escaping (Bool, Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(false, nil)
            return
        }
        
        db.collection("users").document(userUID).updateData(["score": newScore]) { error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
    
    init() {
        Task {
            await fetchQuizzes()
        }
    }
}
