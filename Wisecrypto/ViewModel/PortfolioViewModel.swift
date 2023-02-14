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
  
  init() {
    getUserData()
  }
    
  func getUserData() {
    let request = NSFetchRequest<PortofolioEntity>(entityName: "PortofolioEntity")
    do {
      userCoins = try manager.context.fetch(request)
    } catch let error {
      print("Error fetching \(error)")
    }
  }
  
  func addCoin(coin: Coin) {
    let newCoin = PortofolioEntity(context: manager.context)
    
    newCoin.image = coin.image
    newCoin.symbol = coin.symbol
    newCoin.name = coin.name
    newCoin.priceChange = coin.priceChangePercentage24H
    
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
