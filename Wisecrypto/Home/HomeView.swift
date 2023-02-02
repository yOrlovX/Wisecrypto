//
//  HomeView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 30.01.2023.
//

import SwiftUI

struct HomeView: View {
  
  @StateObject var viewModel = CoinViewModel()
  
  var body: some View {
    VStack(spacing: 20) {
      userSection
      totalPortfolioSection
      myCoinSection
      watchlistSection
    }
    .background(Colors.lightBackground)
  }
}

extension HomeView {
  
  private var userSection: some View {
    HStack(spacing: 12) {
      Image("userImage")
        .resizable().scaledToFit()
        .frame(width: 40, height: 40)
      VStack(alignment: .leading) {
        Text("Hello")
          .font(.system(size: 12, weight: .semibold))
          .foregroundColor(.gray)
        Text("Nadila Aulia")
          .font(.system(size: 20, weight: .bold))
      }
      Spacer()
      Image(systemName: "bell")
        .resizable()
        .scaledToFit()
        .frame(width: 24, height: 24)
    }
    .padding(.horizontal, 15)
  }
  
  private var totalPortfolioSection: some View {
    Rectangle()
      .frame(width: UIScreen.main.bounds.width - 30, height: 112)
      .foregroundColor(Colors.primaryGreen)
      .cornerRadius(10)
      .overlay {
        HStack {
          VStack {
            Text("Total Portofolio")
              .font(.system(size: 16, weight: .semibold))
              .foregroundColor(.white)
            Text("$56.98")
              .font(.system(size: 32, weight: .bold))
              .foregroundColor(.white)
          }
          Spacer()
          Rectangle()
            .frame(width: 55, height: 22)
            .foregroundColor(.white)
            .cornerRadius(8)
            .overlay {
              HStack(spacing: 2) {
                Image(systemName: "arrow.up.right")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 6, height: 6)
                  .foregroundColor(Colors.primaryGreen)
                  .padding(.vertical, 4)
                Text("\(String(format:"%.1f", 15))%")
                  .font(.system(size: 10, weight: .bold))
                  .foregroundColor(Colors.primaryGreen)
                  .padding(.vertical, 4)
              }
            }
        }
        .padding(.horizontal, 25)
      }
  }
  
  private var myCoinSection: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Text("My Coins")
          .font(.system(size: 14, weight: .semibold))
        Spacer()
        Text("See all")
          .font(.system(size: 12, weight: .bold))
          .foregroundColor(Colors.primaryGreen)
      }
      ScrollView(.horizontal) {
        LazyHStack(spacing: 16) {
          ForEach(viewModel.coinData) { data in
            MyCoinsCell(image: data.image, symbol: data.symbol, name: data.name, currentPrice: data.currentPrice, priceChange: data.priceChange24H)
          }
        }
      }
      .frame(height: 119)
    }
    .padding(.horizontal, 15)
  }
  
  private var watchlistSection: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("Watchlist")
        .font(.system(size: 14, weight: .semibold))
      ScrollView(.vertical, showsIndicators: true) {
        LazyVStack(spacing: 8) {
          ForEach(viewModel.coinData) { data in
            CoinCell(image: data.image, symbol: data.symbol, name: data.name, currentPrice: data.currentPrice, priceChange: data.priceChangePercentage24H)
          }
        }
      }
    }
    .padding(.horizontal, 15)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
