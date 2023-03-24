//
//  AuthViewModel.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 06.03.2023.
//

import Foundation
import SwiftUI
import Combine

final class AuthViewModel: ObservableObject {
  
  private let manager = DataManager.instance
  
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var confirmedPassword: String = ""
  @Published var fullName: String = ""
  @Published var emailStatus: LoginStatus = .notEvaluated
  @Published var passwordStatus: LoginStatus = .notEvaluated
  @Published var currentUser: UserEntity?
  
  @AppStorage("UserRegister") var isRegister: Bool = false
  @AppStorage("UserLogin") var userLogin: Bool = false
  @KeychainStorage("UserPassword") var keychainPassword = MyType(string: "")
  @KeychainStorage("UserMail") var keychainMail = MyType(string: "")
  @KeychainStorage("UserFullName") var keychainFullName = MyType(string: "")
  
  let emailPublisher = PassthroughSubject<String, Never>()
  let passwordPublisher = PassthroughSubject<String, Never>()
  
  init() {
    verifyPasswordStatus()
    verifyEmailStatus()
  }
  
  private func verifyPasswordStatus() {
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
  
  private func verifyEmailStatus() {
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
  
  func registerUser() {
    let user = UserEntity(context: manager.container.viewContext)
    user.email = email
    user.password = password
    user.fullName = fullName
    do {
      try manager.container.viewContext.save()
      self.currentUser = user
    } catch {
      print("Error saving user data: \(error.localizedDescription)")
    }
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
