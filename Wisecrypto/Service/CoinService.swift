//
//  CoinService.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 30.01.2023.
//

import Foundation
import Combine

final class CoinService {
  
  func download(url: URL) -> AnyPublisher<[Coin], Error> {
    URLSession
      .shared
      .dataTaskPublisher(for: url)
      .map { $0.data }
      .receive(on: DispatchQueue.main)
      .decode(type: CoinResponse.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
}

