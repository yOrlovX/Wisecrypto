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
            .onChange(of: viewModel.searchText) { newValue in
              viewModel.searchResults = viewModel.coinData.filter({ result in
                result.name.contains(viewModel.searchText) && viewModel.searchText.count > 1
              })
            }
          
            ScrollView(.vertical, showsIndicators: true) {
              LazyVStack(spacing: 8) {
                ForEach(viewModel.listData) { data in
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
