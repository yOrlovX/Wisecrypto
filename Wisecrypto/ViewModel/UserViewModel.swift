//
//  AuthViewModel.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 06.03.2023.
//

import Foundation
import SwiftUI
import Combine
import CoreData

final class UserViewModel: ObservableObject {
  
  @Published var userData: [UserEntity] = []
  
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
    getUserData()
  }
}

// MARK: verify & validation functions
extension UserViewModel {
  
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
  
  private func isValidEmail() -> Bool {
    let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
    
    return regex.firstMatch(in: email, range: NSRange(location: 0, length: email.count)) != nil
  }
  
  private func isValidPassword(_ password: String) -> Bool {
    let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
    return passwordRegex.evaluate(with: password)
  }
}

//MARK: User operations
extension UserViewModel {
  
  func registerUser() {
    let user = UserEntity(context: manager.context)
    user.email = email
    user.password = password
    user.fullName = fullName
    
    self.currentUser = user
    saveData()
  }
  
  func getUserData() {
    let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
    do {
      userData = try manager.context.fetch(request)
    } catch _ {
      print("Error")
    }
  }
  
  func addImageToUser(_ image: UIImage) {
      guard let user = userData.last else { return }
      user.userImage = image.jpegData(compressionQuality: 0.1)
      saveData()
  }
  
  func getUserBalance() -> Double {
    userData.reduce(0) { $0 + $1.balance}
  }
    
  func update(sum: Double) {
    guard let user = userData.last else { return }
    user.balance = -sum
    saveData()
  }
  
  func saveData() {
    do {
      try manager.container.viewContext.save()
      getUserData()
    } catch let error {
      print("Error saving \(error)")
    }
  }
}
