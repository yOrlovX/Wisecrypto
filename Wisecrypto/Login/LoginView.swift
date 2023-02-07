//
//  LoginView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 07.02.2023.
//

import SwiftUI

struct LoginView: View {
  @State var email: String = ""
  @State var password: String = ""
  @Binding var currentViewShowing: AuthViewState
  
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

extension LoginView {
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
      TextField("botpablo@gmail.com", text: $email)
        .modifier(TextFieldModifier())
      Text("Password")
        .font(.system(size: 14, weight: .medium))
      TextField("Please enter the password", text: $password)
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
      Button(action: {}) {
        Text("Login")
          .modifier(PrimaryGreenButtonModifier())
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
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView(currentViewShowing: .constant(.login))
  }
}
