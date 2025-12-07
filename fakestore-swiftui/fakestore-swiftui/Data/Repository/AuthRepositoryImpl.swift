//
//  AuthRepositoryImpl.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import Foundation
import FirebaseAuth

class AuthRepositoryImpl: AuthRepositoryProtocol {
    
    func login(email: String, password: String) async throws {
        let _ = try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func register(email: String, password: String) async throws {
        let _ = try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
    
    func getCurrentUserEmail() -> String? {
        return Auth.auth().currentUser?.email
    }
    
    var isLoggedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
