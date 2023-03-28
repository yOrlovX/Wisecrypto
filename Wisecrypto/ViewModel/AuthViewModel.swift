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

final class AuthViewModel: ObservableObject {
  
  private let manager = DataManager.instance
  
  @Published var userData: [UserEntity] = []
  @Published var userCoins: [PortofolioEntity] = []
  
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var confirmedPassword: String = ""
  @Published var fullName: String = ""
  @Published var emailStatus: LoginStatus = .notEvaluated
  @Published var passwordStatus: LoginStatus = .notEvaluated
  
  @AppStorage("UserRegister") var isRegister: Bool = false
  @AppStorage("UserLogin") var userLogin: Bool = false
  @KeychainStorage("UserPassword") var savedPassword = MyType(string: "")
  @KeychainStorage("UserMail") var savedMail = MyType(string: "")
  @KeychainStorage("UserInitials") var savedInitials = MyType(string: "")
  
  let emailPublisher = PassthroughSubject<String, Never>()
  let passwordPublisher = PassthroughSubject<String, Never>()
  
  init() {
    verifyPasswordStatus()
    verifyEmailStatus()
    getUserData()
    getPortfolioData()
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
  
  
  private func isValidEmail() -> Bool {
    let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
    
    return regex.firstMatch(in: email, range: NSRange(location: 0, length: email.count)) != nil
  }
  
  private func isValidPassword(_ password: String) -> Bool {
    let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
    return passwordRegex.evaluate(with: password)
  }
  
  func registerUser() {
    let newUser = UserEntity(context: manager.context)
    newUser.fullName = fullName
    newUser.password = password
    newUser.email = email
    
    saveData()
  }
  
  func saveData() {
    do {
      try manager.container.viewContext.save()
      print("User Data saved")
      getUserData()
    } catch let error {
      print("Error saving \(error)")
    }
  }
  
  func getUserData() {
    let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
    do {
      userData = try manager.context.fetch(request)
    } catch let error {
      print("Error fetching: \(error)")
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
  
  
  func addCoin(image: String, symbol: String, name: String, priceChange: Double, sum: Double, currentPrice: Double) {
    let newCoin = PortofolioEntity(context: manager.context)
    
    newCoin.image = image
    newCoin.symbol = symbol
    newCoin.name = name
    newCoin.priceChange = priceChange
    newCoin.sum = sum
    newCoin.currentPrice = currentPrice
    newCoin.user = userData[0]
    
    saveData()
    getPortfolioData()
  }
  
  func addUserBalance(balance: Double) {
    guard let user = userData.last else { return }
    user.balance += balance
    saveData()
  }
  
  
  func getPortfolioData() {
    let request = NSFetchRequest<PortofolioEntity>(entityName: "PortofolioEntity")
    do {
      userCoins = try manager.context.fetch(request)
    } catch let error {
      print("Error fetching \(error)")
    }
  }
  
  func totalCoinsSum() -> Double {
    userCoins.reduce(0) { $0 + $1.sum }
  }
  
  func portfolioCurrentPecentage() -> Double {
    userCoins.reduce(0) { $0 + $1.priceChange}
  }
}

