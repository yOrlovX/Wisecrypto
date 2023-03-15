//
//  AuthViewModel.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 06.03.2023.
//

import Foundation
import SwiftUI
import Combine

enum LoginStatus {
  case login
  case fail
  case notEvaluated
}

class AuthViewModel: ObservableObject {
  
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var confirmedPassword: String = ""
  @Published var fullName: String = ""
  @Published var emailStatus: LoginStatus = .notEvaluated
  @Published var passwordStatus: LoginStatus = .notEvaluated
  @AppStorage("UserRegister") var isRegister: Bool = false
  
  let emailPublisher = PassthroughSubject<String, Never>()
  let passwordPublisher = PassthroughSubject<String, Never>()
    
  init() {
    verifyPasswordStatus()
    verifyEmailStatus()
  }
      
  func verifyPasswordStatus() {
    passwordPublisher
      .map { password -> LoginStatus in
        if self.isValidPassword(self.password) {
          return LoginStatus.login
        } else {
          return LoginStatus.fail
        }
      }
      .assign(to: &$passwordStatus)
  }
  
  func verifyEmailStatus() {
    emailPublisher
      .map { email -> LoginStatus in
        if self.isValidEmail() {
          return LoginStatus.login
        } else {
          return LoginStatus.fail
        }
      }
      .assign(to: &$emailStatus)
  }
  
    
   private func isValidEmail() -> Bool {
    let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
    
    return regex.firstMatch(in: email, range: NSRange(location: 0, length: email.count)) != nil
  }
  
  private func isValidPassword(_ password: String) -> Bool {
    let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
    return passwordRegex.evaluate(with: password)
  }
}
