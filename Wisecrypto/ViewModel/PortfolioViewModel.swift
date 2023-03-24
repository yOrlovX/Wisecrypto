//
//  PortfolioViewModel.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 13.02.2023.
//

import Foundation
import CoreData
import UIKit

final class PortfolioViewModel: ObservableObject {
  
  private let manager = DataManager.instance
  @Published var userCoins: [PortofolioEntity] = []
  
  init() {
    getPortfolioData()
    
  }
    
  func getPortfolioData() {
    let request = NSFetchRequest<PortofolioEntity>(entityName: "PortofolioEntity")
    do {
      userCoins = try manager.context.fetch(request)
    } catch let error {
      print("Error fetching \(error)")
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
    } catch let error {
      print("Error saving \(error)")
    }
  }
}
