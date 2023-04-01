//
//  CoinDetailView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 08.02.2023.
//

import SwiftUI
import CachedAsyncImage

struct CoinDetailView: View {
  let coin: Coin
  @State var isPresented: Bool = false
  
  var body: some View {
    VStack(spacing: 20) {
      CachedAsyncImage(url: URL(string: coin.image), urlCache: .imageCache) { image in
        image
          .resizable()
          .scaledToFit()
      } placeholder: {
        ProgressView()
      }
      .frame(width: 64, height: 64)
      HStack {
        Text(String(format: "%.2f", coin.currentPrice))
          .font(.system(size: 24, weight: .semibold))
        
        Text(coin.symbol.uppercased())
          .font(.system(size: 24, weight: .semibold))
      }
      RoundedRectangle(cornerRadius: 20)
        .frame(width: 80, height: 33)
        .foregroundColor(coin.priceChangePercentage24H ?? 0 < 0 ? Colors.primaryRed : Colors.primaryGreen)
        .overlay {
          HStack(spacing: 4) {
            Image(systemName: coin.priceChangePercentage24H ?? 0 < 0 ? "chevron.down" : "chevron.up")
              .foregroundColor(.white)
            Text("\(String(format: "%.2f", coin.priceChangePercentage24H ?? 0))%")
              .font(.system(size: 14, weight: .medium))
              .foregroundColor(.white)
          }
        }
      Spacer()
      ChartView(data: coin.sparklineIn7D.price, maxPrice: coin.sparklineIn7D.price.max() ?? 0, minPrice: coin.sparklineIn7D.price.min() ?? 0, startingDate: Date(), endingDate: Date().addingTimeInterval(-7*24*60*60), rank: coin.marketCapRank)
      
      Spacer()
      Button(action: { isPresented.toggle() }) {
        Text("Add")
          .modifier(PrimaryGreenButtonModifier())
      }
      Spacer()
    }
    .sheet(isPresented: $isPresented, onDismiss: nil) {
      AddCoinsView(coin: coin)
    }
    .background(Colors.lightBackground)
    .navigationBarTitle(coin.name)
  }
}
