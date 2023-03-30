//
//  LoginView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 07.02.2023.
//

import SwiftUI

struct LoginView: View {
  
  @EnvironmentObject private var userViewModel: UserViewModel
  @Binding var currentViewShowing: AuthViewState
  @State private var incorrectCredentialsAllert: Bool = false
  
  var body: some View {
    ZStack {
      Colors.lightBackground
        .ignoresSafeArea()
      VStack(spacing: 32) {
        Spacer()
        logoContainer
        textFieldContainer
        buttonsContainer
        Spacer()
      }
    }
  }
}

private extension LoginView {
  private var logoContainer: some View {
    VStack(spacing: 4) {
      HStack {
        Image("Logo")
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .frame(width: 48, height: 43)
          .foregroundColor(Colors.primaryGreen)
        
        Text("Wisecrypto")
          .font(.system(size: 30, weight: .bold))
      }
      Text("Trusted by millions of users worldwide")
        .font(.system(size: 14, weight: .semibold))
        .foregroundColor(Colors.primaryGreen)
    }
  }
  
  private var textFieldContainer: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("Email")
        .font(.system(size: 14, weight: .medium))
      HStack {
        TextField("botpablo@gmail.com", text: $userViewModel.email)
          .onChange(of: userViewModel.email) { newValue in
            userViewModel.emailPublisher.send(newValue)
          }
      }
      .modifier(TextFieldModifier())
      Text("Password")
        .font(.system(size: 14, weight: .medium))
      HStack {
        TextField("Please enter the password", text: $userViewModel.password)
          .onChange(of: userViewModel.password) { newValue in
            userViewModel.passwordPublisher.send(newValue)
          }
      }
      .modifier(TextFieldModifier())
    }
    .padding(.horizontal, 15)
  }
  
  private var buttonsContainer: some View {
    VStack(spacing: 24) {
      Button(action: {}) {
        Text("Forgot password?")
          .font(.system(size: 12, weight: .semibold))
          .foregroundColor(Colors.primaryYellow)
      }
      Button(action: {
        userViewModel.login()
        if userViewModel.canLogin {
          userViewModel.isUserLoggedIn = true
        } else {
          incorrectCredentialsAllert = true
        }
      }) {
        Text("Login")
          .modifier(PrimaryGreenButtonModifier())
      }
      .alert("Incorrect or empty credentials", isPresented: $incorrectCredentialsAllert) {
        Button("OK", role: .cancel) { }
      }
      Button(action: {
        withAnimation(.easeIn) {
          self.currentViewShowing = .register
        }
      }) {
        Text("Don't have an account yet? Register here")
          .font(.system(size: 12, weight: .regular))
          .foregroundColor(Colors.primaryGreen)
      }
    }
  }
  
  struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
      LoginView(currentViewShowing: .constant(.login))
    }
  }
}
