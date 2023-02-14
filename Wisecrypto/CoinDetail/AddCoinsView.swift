//
//  AddCoinsView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 14.02.2023.
//

import SwiftUI

struct AddCoinsView: View {
  @Environment(\.presentationMode) var presentationMode
  @StateObject var portfolioViewModel = PortfolioViewModel()
  @State private var sumForCoin: String = ""
  @State private var coinSum: String = ""
  let coin: Coin
  
  var body: some View {
    VStack(spacing: 50) {
      TextField("$", text: $sumForCoin)
        .font(.system(size: 52, weight: .bold))
        .padding()
        .font(.system(.subheadline))
        .frame(width: 160, height: 56)
        .modifier(TextFieldModifier())
      
      VStack(spacing: 10) {
        AsyncImage(url: URL(string: coin.image)) { image in
          image
            .resizable()
            .scaledToFit()
        } placeholder: {
          ProgressView()
        }
        .frame(width: 64, height: 64)
        
        Text(coin.symbol.uppercased())
          .font(.system(size: 20, weight: .bold))
          .foregroundColor(.black)
      }
      Button(action: { portfolioViewModel.addCoin(image: coin.image, symbol: coin.symbol, name: coin.name, priceChange: coin.priceChangePercentage24H, sum: Double(sumForCoin) ?? 0, currentPrice: coin.currentPrice)
        self.presentationMode.wrappedValue.dismiss()
      }) {
        Text("Buy coins")
          .modifier(PrimaryGreenButtonModifier())
      }
    }
  }
}
//struct AddCoinsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCoinsView()
//    }
//}
