//
//  MarketView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 04.02.2023.
//

import SwiftUI

struct MarketView: View {
  @StateObject private var viewModel = CoinViewModel()
  
    var body: some View {
      ZStack {
        Colors.lightBackground
          .ignoresSafeArea()
        VStack {
          SearchBarView(searchText: $viewModel.searchText)
          
            ScrollView(.vertical, showsIndicators: true) {
              LazyVStack(spacing: 8) {
                ForEach(viewModel.coinData) { data in
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
    }
}
