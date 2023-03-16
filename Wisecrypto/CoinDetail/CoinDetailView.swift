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
    ZStack {
      ScrollView {
        VStack {
          Text(coin.name)
            .font(.system(size: 16, weight: .bold))
          CachedAsyncImage(url: URL(string: coin.image), urlCache: .imageCache) { image in
            image
              .resizable()
              .scaledToFit()
          } placeholder: {
            ProgressView()
          }
          .frame(width: 64, height: 64)
          HStack {
            Text(String(format: "%.4f", coin.currentPrice))
              .font(.system(size: 24, weight: .semibold))
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
          }
          
          ChartView(data: coin.sparklineIn7D.price, maxPrice: coin.sparklineIn7D.price.max() ?? 0, minPrice: coin.sparklineIn7D.price.min() ?? 0, startingDate: Date(), endingDate: Date().addingTimeInterval(-7*24*60*60), rank: coin.marketCapRank)
        }
        .padding(.top, 50)
        Button(action: { isPresented.toggle()}) {
          Image(systemName: "plus.circle")
            .resizable()
            .scaledToFit()
            .foregroundColor(Colors.primaryGreen)
            .frame(width: 50, height: 50)
        }
      }
    }
    .background(Colors.lightBackground)
    .ignoresSafeArea()
    .sheet(isPresented: $isPresented, onDismiss: dismiss) {
      AddCoinsView(coin: coin)
    }
  }
  
  func dismiss() {}
}

extension CoinDetailView {
  private var coinStaticticSection: some View {
    VStack {
      HStack {
        VStack(alignment: .leading, spacing: 4) {
          Text("Market cap rank")
            .font(.system(size: 12, weight: .medium))
          Text("\(coin.marketCapRank)")
            .font(.system(size: 16, weight: .medium))
        }
        Spacer()
      }
      Divider()
      HStack {
        VStack(alignment: .leading, spacing: 4) {
          Text("Market cap")
            .font(.system(size: 12, weight: .medium))
          Text("\(coin.marketCap)")
            .font(.system(size: 16, weight: .medium))
        }
        Spacer()
        HStack(spacing: 4) {
          Image(systemName: coin.marketCapChangePercentage24H ?? 0 < 0 ? "chevron.down" : "chevron.up")
            .foregroundColor(coin.marketCapChangePercentage24H ?? 0 < 0 ? Colors.primaryRed : Colors.primaryGreen)
          Text("\(String(format: "%.2f", coin.marketCapChangePercentage24H ?? 0))%")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(coin.marketCapChangePercentage24H ?? 0 < 0 ? Colors.primaryRed : Colors.primaryGreen)
        }
      }
      Divider()
      HStack {
        VStack(alignment: .leading, spacing: 4) {
          Text("High 24h")
            .font(.system(size: 12, weight: .medium))
          Text(String(format: "%.2f", coin.high24H ?? 0))
            .font(.system(size: 16, weight: .medium))
        }
        Spacer()
      }
      Divider()
      HStack {
        VStack(alignment: .leading, spacing: 4) {
          Text("Low 24h")
            .font(.system(size: 12, weight: .medium))
          Text(String(format: "%.2f", coin.low24H ?? 0))
            .font(.system(size: 16, weight: .medium))
        }
        Spacer()
      }
    }
    .padding(15)
  }
}
