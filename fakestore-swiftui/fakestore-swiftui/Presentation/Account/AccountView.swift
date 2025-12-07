//
//  AccountView.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//


import SwiftUI

struct AccountView: View {
    @StateObject var viewModel: AccountViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
            
            Text(viewModel.userEmail)
                .font(.title2)
                .fontWeight(.semibold)
            
            Button(action: {
                viewModel.logout()
            }) {
                Text("Logout")
                    .foregroundColor(.red)
                    .fontWeight(.medium)
            }
            
            Spacer()
        }
        .padding(.top, 60)
    }
}
