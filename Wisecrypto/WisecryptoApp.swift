//
//  WisecryptoApp.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 30.01.2023.
//

import SwiftUI

@main
struct WisecryptoApp: App {
  @StateObject var coinsViewModel = CoinsViewModel()
  @StateObject var portfolioViewModel = PortfolioViewModel()
    var body: some Scene {
        WindowGroup {
          MainView()
            .environmentObject(coinsViewModel)
            .environmentObject(portfolioViewModel)
        }
    }
}
