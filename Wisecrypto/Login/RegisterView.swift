//
//  RegisterView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 07.02.2023.
//

import SwiftUI

struct MyType: Codable {
  let string: String
}

struct RegisterView: View {
  @Binding var currentViewShowing: AuthViewState
  @EnvironmentObject private var authViewModel: AuthViewModel
  
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

private extension RegisterView {
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
      Text("Full name")
        .font(.system(size: 14, weight: .medium))
      TextField("Axel Rose", text: $authViewModel.fullName)
        .modifier(TextFieldModifier())
      Text("Email")
        .font(.system(size: 14, weight: .medium))
      HStack {
        TextField("botpablo@gmail.com", text: $authViewModel.email)
          .onChange(of: authViewModel.email) { newValue in
            authViewModel.emailPublisher.send(newValue)
          }
        if authViewModel.email.count != 0 {
          Image(systemName: authViewModel.emailStatus == .login ? "checkmark" : "xmark")
            .foregroundColor(authViewModel.emailStatus == .login ? Colors.primaryGreen : Colors.primaryRed)
        }
      }
      .modifier(TextFieldModifier())
      Text("Password")
        .font(.system(size: 14, weight: .medium))
      HStack {
        TextField("Please enter the password", text: $authViewModel.password)
          .onChange(of: authViewModel.password) { newValue in
            authViewModel.passwordPublisher.send(newValue)
          }
        if authViewModel.password.count != 0 {
          Image(systemName: authViewModel.passwordStatus == .login ? "checkmark" : "xmark")
            .foregroundColor(authViewModel.passwordStatus == .login ? Colors.primaryGreen : Colors.primaryRed)
        }
      }
      .modifier(TextFieldModifier())
      Text("Confirm Password")
        .font(.system(size: 14, weight: .medium))
      HStack {
        TextField("Please confirm Password", text: $authViewModel.confirmedPassword)
        if authViewModel.confirmedPassword.count != 0 {
          Image(systemName: authViewModel.confirmedPassword == authViewModel.password ? "checkmark" : "xmark")
            .foregroundColor(authViewModel.confirmedPassword == authViewModel.password ? Colors.primaryGreen : Colors.primaryRed)
        }
      }
      .modifier(TextFieldModifier())
      
    }
    .padding(.horizontal, 15)
  }
  
  private var buttonsContainer: some View {
    VStack(spacing: 24) {
      Button(action: {
        authViewModel.savedPassword = MyType(string: authViewModel.password)
        authViewModel.savedMail = MyType(string: authViewModel.email)
        authViewModel.savedInitials = MyType(string: authViewModel.fullName)
        authViewModel.userLogin = true
      }) {
        Text("Register")
          .modifier(PrimaryGreenButtonModifier())
      }
      Button(action: {
        withAnimation(.easeOut) {
          self.currentViewShowing = .login
        }
      }) {
        Text("Already have account ? Log In")
          .font(.system(size: 12, weight: .regular))
          .foregroundColor(Colors.primaryGreen)
      }
    }
  }
}

struct RegisterView_Previews: PreviewProvider {
  static var previews: some View {
    RegisterView(currentViewShowing: .constant(.register))
  }
}
