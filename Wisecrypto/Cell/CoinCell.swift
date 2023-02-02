//
//  CoinCell.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 30.01.2023.
//

import SwiftUI

struct CoinCell: View {
  var image: String
  var symbol: String
  var name: String
  var currentPrice: Double
  var priceChange: Double
  
  init(image: String, symbol: String, name: String, currentPrice: Double, priceChange: Double) {
    self.image = image
    self.symbol = symbol
    self.name = name
    self.currentPrice = currentPrice
    self.priceChange = priceChange
  }
  
    var body: some View {
      HStack {
        AsyncImage(url: URL(string: image)) { image in
          image
            .resizable()
            .scaledToFit()
        } placeholder: {
          ProgressView()
        }
        .frame(width: 64, height: 64)
        VStack(alignment: .leading, spacing: 4) {
          Text(symbol.uppercased())
            .font(.system(size: 20, weight: .bold))
          Text(name)
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(Colors.textGray)
        }
        Spacer()
        VStack(alignment:.trailing, spacing: 2) {
          Text("$\(String(format:"%.4f", currentPrice))")
            .font(.system(size: 16, weight: .bold))
          Rectangle()
            .frame(width: 55, height: 22)
            .foregroundColor(priceChange < 0 ? Colors.primaryRed : Colors.primaryGreen)
            .cornerRadius(8)
            .overlay {
              HStack(spacing: 2) {
                Image(systemName: changeImage())
                  .resizable()
                  .scaledToFit()
                  .frame(width: 6, height: 6)
                  .foregroundColor(.white)
                  .padding(.vertical, 4)
                Text("\(String(format:"%.1f", priceChange))%")
                  .font(.system(size: 10, weight: .bold))
                  .foregroundColor(.white)
                  .padding(.vertical, 4)
              }
            }
        }
        .padding(.horizontal, 16)
      }
      .frame(maxWidth: .infinity)
      .padding(.vertical, 12)
      .background(.white)
      .cornerRadius(10)
    }
  
  func changeImage() -> String {
    if priceChange < 0 {
      return "arrow.down.left"
    } else {
      return "arrow.up.right"
    }
  }
}

struct CoinCell_Previews: PreviewProvider {
    static var previews: some View {
      CoinCell(image: "bts", symbol: "BTC/BUSD", name: "Bitcoin", currentPrice: 54.38264, priceChange: 15.3)
        .previewLayout(.sizeThatFits)
    }
}
