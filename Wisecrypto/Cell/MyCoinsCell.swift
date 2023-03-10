//
//  MyCoinsCell.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 31.01.2023.
//

import SwiftUI
import CachedAsyncImage

struct MyCoinsCell: View {
  var image: String
  var symbol: String
  var name: String
  var currentPrice: Double
  var priceChange: Double
  var sum: Double
  
  init(image: String, symbol: String, name: String, currentPrice: Double, priceChange: Double, sum: Double) {
    self.image = image
    self.symbol = symbol
    self.name = name
    self.currentPrice = currentPrice
    self.priceChange = priceChange
    self.sum = sum
  }
  var body: some View {
    VStack {
      HStack {
        CachedAsyncImage(url: URL(string: image), urlCache: .imageCache) { image in
          image
            .resizable()
            .scaledToFit()
        } placeholder: {
          ProgressView()
        }
        .frame(width: 40, height: 40)
        VStack(alignment: .leading, spacing: 4) {
          Text(symbol.uppercased())
            .font(.system(size: 16, weight: .bold))
          Text(name)
            .font(.system(size: 10, weight: .regular))
            .foregroundColor(Colors.textGray)
        }
        Spacer()
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
      .padding(.top, 16)
      Divider()
        .frame(width: 160, height: 1)
      VStack(alignment: .leading) {
        Text("Portfolio")
          .font(.system(size: 10, weight: .regular))
          .foregroundColor(Colors.textGray)
        HStack {
          Text("$\(String(format:"%.2f", sum))")
            .font(.system(size: 14, weight: .bold))
          Spacer()
          Text("\(sum / currentPrice) \(symbol.uppercased())")
            .font(.system(size: 10, weight: .bold))
        }
      }
      .padding(.horizontal, 16)
      .padding(.bottom, 16)
      .padding(.top, 8)
    }
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
struct MyCoinsCell_Previews: PreviewProvider {
  static var previews: some View {
    MyCoinsCell(image: "bts", symbol: "BTC", name: "Bitcoin", currentPrice: 54.38264, priceChange: 15.3, sum: 300)
      .previewLayout(.sizeThatFits)
  }
}

