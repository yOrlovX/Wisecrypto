//
//  PortfolioViewModel.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 13.02.2023.
//

import Foundation
import CoreData

class PortfolioViewModel: ObservableObject {
  
  let manager = DataManager.instance
  @Published var userCoins: [PortofolioEntity] = []
  @Published var userData: [UserEntity] = []
  
  init() {
    getPortfolioData()
    getUserData()
  }
    
  func getPortfolioData() {
    let request = NSFetchRequest<PortofolioEntity>(entityName: "PortofolioEntity")
    do {
      userCoins = try manager.context.fetch(request)
    } catch let error {
      print("Error fetching \(error)")
    }
  }
  
  func getUserData() {
    let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
    do {
      userData = try manager.context.fetch(request)
    } catch _ {
      print("Error")
    }
  }
  
  func addUserBalance(balance: Double) {
    let user = UserEntity(context: manager.context)
    user.balance = balance
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
  
  func totalCoinsSum() -> Double {
    userCoins.reduce(0) { $0 + $1.sum }
  }
  
  func portfolioCurrentPecentage() -> Double {
    userCoins.reduce(0) { $0 + $1.priceChange}
  }
  
  func saveData() {
    do {
      try manager.container.viewContext.save()
      getPortfolioData()
      getUserData()
    } catch let error {
      print("Error saving \(error)")
    }
  }
}
