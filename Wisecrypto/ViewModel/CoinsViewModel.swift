//
//  CoinViewModel.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 30.01.2023.
//

import Foundation
import Combine
import UIKit

final class CoinsViewModel: ObservableObject {
  @Published var coinData: [Coin] = []
  @Published var searchText: String = ""
  @Published var searchResults: [Coin] = []
  
  private let coinService = CoinService()
  
  private var cancellables = Set<AnyCancellable>()
  
  var listData: [Coin] {
    if searchText.isEmpty {
      return coinData
    } else {
      return searchResults
    }
  }
  
  init() {
    fetchCoinsFromResponse()
  }
  
  func sortedByPercentChange() {
    coinData.sort { $0.priceChangePercentage24H ?? 0 > $1.priceChangePercentage24H ?? 0 }
  }
  
  func sortedByCoinRank() {
    coinData.sort { $0.marketCapRank < $1.marketCapRank }
  }
  
  func sortByMaxPrice() {
    coinData.sort { $0.high24H ?? 0 > $1.high24H ?? 0}
  }
  
  func sortByMinPrice() {
    coinData.sort { $0.high24H ?? 0 < $1.high24H ?? 0}
  }
  
  private func fetchCoinsFromResponse() {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
    coinService.download(url: url)
      .sink { completion in
        switch completion {
        case .finished:
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
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [unowned self] returnedData in
        self.coinData = returnedData
      }
      .store(in: &cancellables)
  }
  
  private func fetchCoinsDataWithAsyncAwait() async {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
    
    do {
      let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
      let returnedData = try JSONDecoder().decode(CoinResponse.self, from: data)
      await MainActor.run {
        self.coinData = returnedData
      }
    } catch {
      print(error.localizedDescription)
    }
  }
}
