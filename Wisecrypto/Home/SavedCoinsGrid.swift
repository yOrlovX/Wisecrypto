//
//  MyCoinsGrid.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 31.03.2023.
//

import SwiftUI
import CachedAsyncImage

struct SavedCoinsGrid: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
      ZStack {
        Colors.lightBackground
          .ignoresSafeArea()
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(userViewModel.userCoins) { coin in
                    SavedCoinCell(coin: coin)
                }
            }
            .padding(.horizontal)
            .padding(.top, 16)
        }
      }
    }
}

struct SavedCoinCell: View {
    let coin: PortofolioEntity
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
          CachedAsyncImage(url: URL(string: coin.image ?? ""), urlCache: .imageCache) { image in
            image
              .resizable()
              .scaledToFit()
          } placeholder: {
            ProgressView()
          }
            Text(coin.name ?? "")
                .font(.headline)
          Text(coin.symbol?.uppercased() ?? "")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("$\(coin.sum, specifier: "%.2f")")
                .font(.subheadline)
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
    }
}
