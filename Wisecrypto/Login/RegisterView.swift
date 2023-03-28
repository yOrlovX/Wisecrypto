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
  @EnvironmentObject private var userViewModel: UserViewModel
  
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
      TextField("Axel Rose", text: $userViewModel.fullName)
        .modifier(TextFieldModifier())
      Text("Email")
        .font(.system(size: 14, weight: .medium))
      HStack {
        TextField("botpablo@gmail.com", text: $userViewModel.email)
          .onChange(of: userViewModel.email) { newValue in
            userViewModel.emailPublisher.send(newValue)
          }
        if userViewModel.email.count != 0 {
          Image(systemName: userViewModel.emailStatus == .login ? "checkmark" : "xmark")
            .foregroundColor(userViewModel.emailStatus == .login ? Colors.primaryGreen : Colors.primaryRed)
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
        if userViewModel.password.count != 0 {
          Image(systemName: userViewModel.passwordStatus == .login ? "checkmark" : "xmark")
            .foregroundColor(userViewModel.passwordStatus == .login ? Colors.primaryGreen : Colors.primaryRed)
        }
      }
      .modifier(TextFieldModifier())
      Text("Confirm Password")
        .font(.system(size: 14, weight: .medium))
      HStack {
        TextField("Please confirm Password", text: $userViewModel.confirmedPassword)
        if userViewModel.confirmedPassword.count != 0 {
          Image(systemName: userViewModel.confirmedPassword == userViewModel.password ? "checkmark" : "xmark")
            .foregroundColor(userViewModel.confirmedPassword == userViewModel.password ? Colors.primaryGreen : Colors.primaryRed)
        }
      }
      .modifier(TextFieldModifier())
      
    }
    .padding(.horizontal, 15)
  }
  
  private var buttonsContainer: some View {
    VStack(spacing: 24) {
      Button(action: {
        userViewModel.savedPassword = MyType(string: userViewModel.password)
        userViewModel.savedMail = MyType(string: userViewModel.email)
        userViewModel.savedInitials = MyType(string: userViewModel.fullName)
        userViewModel.userLogin = true
        userViewModel.registerUser()
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
