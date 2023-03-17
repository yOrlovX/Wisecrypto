//
//  AuthView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 07.02.2023.
//

import SwiftUI

struct AuthView: View {
  @State private var currentViewShowing: AuthViewState = .login
  @EnvironmentObject private var authViewModel: AuthViewModel
  
  var body: some View {
    ZStack {
      if authViewModel.userLogin {
        MainView()
      } else {
        switch currentViewShowing {
        case .login:
          LoginView(currentViewShowing: $currentViewShowing)
        case .register:
          RegisterView(currentViewShowing: $currentViewShowing)  
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
