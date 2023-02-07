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
}

struct AuthView: View {
  @State private var currentViewShowing: AuthViewState = .login
  
  var body: some View {
    ZStack {
      if currentViewShowing == .login {
        LoginView(currentViewShowing: $currentViewShowing)
          .transition(.move(edge: .top))
      } else {
        RegisterView(currentViewShowing: $currentViewShowing)
          .transition(.move(edge: .bottom))
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
