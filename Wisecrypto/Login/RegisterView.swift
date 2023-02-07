//
//  RegisterView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 07.02.2023.
//

import SwiftUI

struct RegisterView: View {
  @State var fullName: String = ""
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

extension RegisterView {
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
      TextField("Axel Rose", text: $email)
        .modifier(TextFieldModifier())
      Text("Email")
        .font(.system(size: 14, weight: .medium))
      TextField("botpablo@gmail.com", text: $email)
        .modifier(TextFieldModifier())
      Text("Password")
        .font(.system(size: 14, weight: .medium))
      TextField("Please enter the password", text: $password)
        .modifier(TextFieldModifier())
      Text("Conform Password")
        .font(.system(size: 14, weight: .medium))
      TextField("Please conform Password", text: $password)
        .modifier(TextFieldModifier())
    }
    .padding(.horizontal, 15)
  }
  
  private var buttonsContainer: some View {
    VStack(spacing: 24) {
      Button(action: {}) {
        Text("Login")
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
