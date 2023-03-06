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
          GeometryReader { firstFrame in
            ScrollView(.vertical, showsIndicators: true) {
                LazyVStack(spacing: 8) {
                  ForEach(coinsViewModel.listData) { data in
                    GeometryReader { animationArea in
                      CoinCell(rowData: data)
                        .scaleEffect(dimensionValue(firstFrame: firstFrame.frame(in: .global).minY, minY: animationArea.frame(in: .global).minY))
                        .opacity(Double(dimensionValue(firstFrame: firstFrame.frame(in: .global).minY, minY: animationArea.frame(in: .global).minY)))
                    }
                    .frame(height: 85)
                  }
                }
                .padding(15)
            }
            .zIndex(1.0)
          }
        }
      }
    }
  
  func dimensionValue(firstFrame: CGFloat, minY: CGFloat) -> CGFloat {
    withAnimation(.easeIn(duration: 1)) {
      let dimension = (minY - 15) / firstFrame
      if dimension > 1 {
        return 1
      } else {
        return dimension
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
