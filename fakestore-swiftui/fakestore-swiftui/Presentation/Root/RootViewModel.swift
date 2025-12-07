//
//  RootViewModel.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import Foundation
import FirebaseAuth
import Combine

@MainActor
class RootViewModel: ObservableObject {
    @Published var isUserLoggedIn: Bool = false
    
    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { _, user in
            self.isUserLoggedIn = (user != nil)
        }
    }
    
    deinit {
        if let handle = authStateListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
