//
//  AuthRepositoryProtocol.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import Foundation

protocol AuthRepositoryProtocol {
    func login(email: String, password: String) async throws
    func register(email: String, password: String) async throws
    func logout() throws
    func getCurrentUserEmail() -> String?
    var isLoggedIn: Bool { get }
}
