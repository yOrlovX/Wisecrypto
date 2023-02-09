//
//  CoinDetailView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 08.02.2023.
//

import SwiftUI

struct CoinDetailView: View {
  let coin: Coin
  
  var body: some View {
    ZStack {
      VStack {
        Text(coin.name)
          .font(.system(size: 16, weight: .bold))
        Image(coin.image)
          .resizable()
          .scaledToFit()
          .frame(width: 60, height: 60)
        Text(String(format: "%.4f", coin.currentPrice))
          .font(.system(size: 24, weight: .semibold))
        RoundedRectangle(cornerRadius: 20)
          .frame(width: 80, height: 33)
          .foregroundColor(coin.priceChangePercentage24H < 0 ? Colors.primaryRed : Colors.primaryGreen)
          .overlay {
            HStack(spacing: 4) {
              Image(systemName: coin.priceChangePercentage24H < 0 ? "chevron.down" : "chevron.up")
                .foregroundColor(.white)
              Text("\(String(format: "%.2f", coin.priceChangePercentage24H))%")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
            }
          }
        HStack {
          Text("Days section")
        }
        coinStaticticSection
      }
    }
    .background(Colors.lightBackground)
    .ignoresSafeArea()
  }
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
          Image(systemName: coin.marketCapChangePercentage24H < 0 ? "chevron.down" : "chevron.up")
            .foregroundColor(coin.marketCapChangePercentage24H < 0 ? Colors.primaryRed : Colors.primaryGreen)
          Text("\(String(format: "%.2f", coin.marketCapChangePercentage24H))%")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(coin.marketCapChangePercentage24H < 0 ? Colors.primaryRed : Colors.primaryGreen)
        }
      }
      Divider()
      HStack {
        VStack(alignment: .leading, spacing: 4) {
          Text("High 24h")
            .font(.system(size: 12, weight: .medium))
          Text(String(format: "%.2f", coin.high24H))
            .font(.system(size: 16, weight: .medium))
        }
        Spacer()
      }
      Divider()
      HStack {
        VStack(alignment: .leading, spacing: 4) {
          Text("Low 24h")
            .font(.system(size: 12, weight: .medium))
          Text(String(format: "%.2f", coin.low24H))
            .font(.system(size: 16, weight: .medium))
        }
        Spacer()
      }
    }
    .padding(15)
  }
}
  
