//
//  RootView.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//

import SwiftUI

struct RootView: View {
    @StateObject var viewModel = RootViewModel()
    
    let loginViewModel: LoginViewModel
    let registerViewModel: RegisterViewModel
    let mainTabView: MainTabView
    
    var body: some View {
        Group {
            if viewModel.isUserLoggedIn {
                mainTabView
            } else {
                LoginView(viewModel: loginViewModel, registerViewModel: registerViewModel)
            }
        }
        .animation(.easeInOut, value: viewModel.isUserLoggedIn)
    }
}
