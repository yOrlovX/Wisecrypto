//
//  CoinCell.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 30.01.2023.
//

import SwiftUI

struct CoinCell: View {

  let rowData: Coin
    
    var body: some View {
      HStack {
        AsyncImage(url: URL(string: rowData.image)) { image in
          image
            .resizable()
            .scaledToFit()
        } placeholder: {
          ProgressView()
        }
        .frame(width: 64, height: 64)
        VStack(alignment: .leading, spacing: 4) {
          Text(rowData.symbol.uppercased())
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.black)
          Text(rowData.name)
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(Colors.textGray)
        }
        Spacer()
        VStack(alignment:.trailing, spacing: 2) {
          Text("$\(String(format:"%.4f", rowData.currentPrice))")
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.black)
          Rectangle()
            .frame(width: 55, height: 22)
            .foregroundColor(rowData.priceChangePercentage24H ?? 0 < 0 ? Colors.primaryRed : Colors.primaryGreen)
            .cornerRadius(8)
            .overlay {
              HStack(spacing: 2) {
                Image(systemName: rowData.priceChangePercentage24H ?? 0 < 0 ? "arrow.down.left" : "arrow.up.right")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 6, height: 6)
                  .foregroundColor(.white)
                  .padding(.vertical, 4)
                Text("\(String(format:"%.1f", rowData.priceChangePercentage24H ?? 0))%")
                  .font(.system(size: 10, weight: .bold))
                  .foregroundColor(.white)
                  .padding(.vertical, 4)
              }
            }
        }
        .padding(.horizontal, 16)
      }
      .frame(maxWidth: .infinity)
      .padding(.vertical, 12)
      .background(.white)
      .cornerRadius(10)
    }
}

//struct CoinCell_Previews: PreviewProvider {
//    static var previews: some View {
//      CoinCell(image: "bts", symbol: "BTC/BUSD", name: "Bitcoin", currentPrice: 54.38264, priceChange: 15.3)
//        .previewLayout(.sizeThatFits)
//    }
//}
