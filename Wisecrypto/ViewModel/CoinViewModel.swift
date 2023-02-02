//
//  CoinViewModel.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 30.01.2023.
//

import Foundation
import Combine
import UIKit

class CoinViewModel: ObservableObject {
  @Published var coinData: [Coin] = []
  @Published var isLoading: Bool = false
  
  
  private let coinService = CoinService()
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
      self.getCoinsDataFromLocalJSON()
    }
//   fetchCoinsFromResponse()
  }
  
  private func fetchCoinsFromResponse() {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
    coinService.download(url: url)
      .sink { completion in
        switch completion {
        case .finished:
          self.isLoading = true
          print("data was loaded")
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [unowned self] returnedData in
        self.coinData = returnedData
      }
      .store(in: &cancellables)
  }
  
  private func getCoinsDataFromLocalJSON() {
    guard let url = Bundle.main.url(forResource: "Coin", withExtension: "json") else { return }
    
    URLSession
      .shared
      .dataTaskPublisher(for: url)
      .map { $0.data }
      .receive(on: DispatchQueue.main)
      .decode(type: CoinResponse.self, decoder: JSONDecoder())
      .sink { completion in
        switch completion {
        case .finished:
          print("local data was loading")
          self.isLoading = true
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [unowned self] returnedData in
        self.coinData = returnedData
      }
      .store(in: &cancellables)
  }
}
