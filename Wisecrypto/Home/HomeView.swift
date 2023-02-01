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
      VStack {
        userSection
        
        if viewModel.isLoading {
          List(viewModel.coinData) { data in
            CoinCell(image: data.image, symbol: data.symbol, name: data.name, currentPrice: data.currentPrice, priceChange: data.priceChangePercentage24H)
          }
        } else {
          ProgressView()
        }
      }
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
