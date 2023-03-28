//
//  TestCell.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 28.03.2023.
//

import SwiftUI
import CachedAsyncImage

struct PortfolioCoinCell: View {
  
  let entity: UserEntity
  
  var body: some View {
    HStack {
      if let portfolios = entity.portfolio?.allObjects as? [PortofolioEntity] {
        ForEach(portfolios) { portfolio in
          VStack {
            HStack {
              CachedAsyncImage(url: URL(string: portfolio.image ?? ""), urlCache: .imageCache) { image in
                image
                  .resizable()
                  .scaledToFit()
              } placeholder: {
                ProgressView()
              }
              .frame(width: 40, height: 40)
              VStack(alignment: .leading, spacing: 4) {
                Text(portfolio.symbol ?? "")
                  .font(.system(size: 16, weight: .bold))
                Text(portfolio.name ?? "")
                  .font(.system(size: 10, weight: .regular))
                  .foregroundColor(Colors.textGray)
              }
              Spacer()
              Rectangle()
                .frame(width: 55, height: 22)
                .foregroundColor(portfolio.priceChange < 0 ? Colors.primaryRed : Colors.primaryGreen)
                .cornerRadius(8)
                .overlay {
                  HStack(spacing: 2) {
                    Image(systemName: portfolio.priceChange < 0 ? "arrow.down.left" : "arrow.down.right")
                      .resizable()
                      .scaledToFit()
                      .frame(width: 6, height: 6)
                      .foregroundColor(.white)
                      .padding(.vertical, 4)
                    Text("\(String(format:"%.1f", portfolio.priceChange))%")
                      .font(.system(size: 10, weight: .bold))
                      .foregroundColor(.white)
                      .padding(.vertical, 4)
                  }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            Divider()
              .frame(width: 160, height: 1)
            VStack(alignment: .leading) {
              Text("Portfolio")
                .font(.system(size: 10, weight: .regular))
                .foregroundColor(Colors.textGray)
              HStack {
                Text("$\(String(format:"%.2f", portfolio.sum))")
                  .font(.system(size: 14, weight: .bold))
                Spacer()
                Text("\(portfolio.sum / portfolio.currentPrice) \(portfolio.symbol ?? "")")
                  .font(.system(size: 10, weight: .bold))
              }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            .padding(.top, 8)
          }
          .background(.white)
          .cornerRadius(10)
        }
      }
    
  }
}
}
