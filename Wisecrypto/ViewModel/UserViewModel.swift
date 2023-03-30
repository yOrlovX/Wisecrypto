//
//  UserViewModel.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 06.03.2023.
//

import Foundation
import SwiftUI
import Combine
import CoreData

final class UserViewModel: ObservableObject {
  
  private let manager = DataManager.instance
  private let credentialsService = CredentialsService()
  
  @Published var userData: [UserEntity] = []
  @Published var userCoins: [PortofolioEntity] = []
  
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var confirmedPassword: String = ""
  @Published var fullName: String = ""
  @Published var emailStatus: CredentialsStatus = .notEvaluated
  @Published var passwordStatus: CredentialsStatus = .notEvaluated
  @Published var canLogin: Bool = false
  
  @AppStorage("UserLogin") var isUserLoggedIn: Bool = false
  
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
  
  func login() {
    if email == savedMail?.string && password == savedPassword?.string {
      self.canLogin = true
    } else {
      self.canLogin = false
    }
  }
  
  private func verifyPasswordStatus() {
    passwordPublisher
      .map { password -> CredentialsStatus in
        if self.credentialsService.isValidPassword(password) && !password.isEmpty && password != self.savedPassword?.string  {
          return CredentialsStatus.valid
        } else {
          return CredentialsStatus.invalid
        }
      }
      .assign(to: &$passwordStatus)
  }
  
  private func verifyEmailStatus() {
    emailPublisher
      .map { email -> CredentialsStatus in
        if self.credentialsService.isValidEmail(email: email) && !email.isEmpty && email != self.savedMail?.string {
          return CredentialsStatus.valid
        } else {
          return CredentialsStatus.invalid
        }
      }
      .assign(to: &$emailStatus)
  }
    
  func registerUser() {
    let newUser = UserEntity(context: manager.context)
    newUser.fullName = fullName
    newUser.password = password
    newUser.email = email
    savedPassword = MyType(string: password)
    savedMail = MyType(string: email)
    savedInitials = MyType(string: fullName)
    isUserLoggedIn = true
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
    userData.reduce(0) { $0 + $1.balance }
  }
  
  func updateUserBalance(sum: Double) {
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

