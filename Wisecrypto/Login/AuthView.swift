//
//  AuthView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 07.02.2023.
//

import SwiftUI

struct AuthView: View {
  @State private var currentViewShowing: AuthViewState = .login
  @EnvironmentObject private var userViewModel: UserViewModel
  
  var body: some View {
    ZStack {
      if userViewModel.isUserLoggedIn {
        MainView()
      } else {
        switch currentViewShowing {
        case .login:
          LoginView(currentViewShowing: $currentViewShowing)
            .transition(.move(edge: .leading))
        case .register:
          RegisterView(currentViewShowing: $currentViewShowing)
            .transition(.move(edge: .trailing))
        }
      }
    }
    .background(Colors.lightBackground)
    .ignoresSafeArea()
  }
}

struct AuthView_Previews: PreviewProvider {
  static var previews: some View {
    AuthView()
  }
}
