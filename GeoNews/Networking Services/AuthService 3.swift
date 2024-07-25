//
//  AuthViewModel.swift
//  GeoNews
//
//  Created by M1 on 02.07.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    public static var shared = AuthService()
    private init() {}
    
    public func registerUser(with userRequest: RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: userRequest.email, password: userRequest.password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            do {
                let db = Firestore.firestore()
                let userData = try JSONEncoder().encode(userRequest)
                if let jsonObject = try JSONSerialization.jsonObject(with: userData) as? [String: Any] {
                    db.collection("users").document(resultUser.uid).setData(jsonObject) { error in
                        if let error = error {
                            completion(false, error)
                            return
                        }
                        completion(true, nil)
                    }
                }
            } catch {
                completion(false, error)
            }
        }
    }
    
    public func signIn(with userRequest: LoginUserRequest, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) { _, error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    public func signOut(completion: @escaping (Error?)->Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    public func forgotPassword(with email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
    public func fetchUser(completion: @escaping (User?, Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("users").document(userUID).getDocument { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = snapshot?.data() else {
                completion(nil, nil)
                return
            }
            
            do {
                let userData = try JSONSerialization.data(withJSONObject: data)
                let user = try JSONDecoder().decode(User.self, from: userData)
                completion(user, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}
