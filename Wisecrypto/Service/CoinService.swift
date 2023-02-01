//
//  CoinService.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 30.01.2023.
//

import Foundation
import Combine

class CoinService {
  
  func download(url: URL) -> AnyPublisher<[Coin], Error> {
    URLSession
      .shared
      .dataTaskPublisher(for: url)
      .map { $0.data }
      .receive(on: DispatchQueue.main)
      .decode(type: CoinResponse.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
  
  //  func download(url: URL) -> AnyPublisher<Data, Error> {
  //    return URLSession
  //      .shared
  //      .dataTaskPublisher(for: url)
  //      .tryMap { (output) -> Data in
  //        guard let response = output.response as? HTTPURLResponse,
  //              response.statusCode >= 200 && response.statusCode < 300 else {
  //                throw URLError(.badServerResponse)
  //              }
  //        return output.data
  //      }
  //      .receive(on: RunLoop.main)
  //      .eraseToAnyPublisher()
  //  }
}

