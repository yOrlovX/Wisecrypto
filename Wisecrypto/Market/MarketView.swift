//
//  MarketView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 04.02.2023.
//

import SwiftUI

struct MarketView: View {
  @EnvironmentObject var coinsViewModel: CoinsViewModel
  
    var body: some View {
      ZStack {
        Colors.lightBackground
          .ignoresSafeArea()
        VStack {
          SearchBarView(searchText: $coinsViewModel.searchText)
            .onChange(of: coinsViewModel.searchText) { newValue in
              coinsViewModel.searchResults = coinsViewModel.coinData.filter({ result in
                result.name.contains(coinsViewModel.searchText) && coinsViewModel.searchText.count > 1
              })
            }
            ScrollView(.vertical, showsIndicators: true) {
              LazyVStack(spacing: 8) {
                ForEach(coinsViewModel.listData) { data in
                  CoinCell(rowData: data)
                }
              }
              .padding(.horizontal, 15)
            }
        }
      }
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView()
        .environmentObject(CoinsViewModel())
    }
}
