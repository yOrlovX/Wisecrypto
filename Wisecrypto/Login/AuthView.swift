//
//  AuthView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 07.02.2023.
//

import SwiftUI

enum AuthViewState {
  case login
  case register
  case main
}

struct AuthView: View {
  @State private var currentViewShowing: AuthViewState = .login
  @StateObject private var authViewModel = AuthViewModel()
  
  var body: some View {
    ZStack {
      if authViewModel.isRegister {
        MainView()
      } else {
        switch currentViewShowing {
        case .login:
          LoginView(currentViewShowing: $currentViewShowing)
        case .register:
          RegisterView(currentViewShowing: $currentViewShowing)
        case .main:
          MainView()
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
