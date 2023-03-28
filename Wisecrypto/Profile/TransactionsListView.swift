//
//  TransactionsListView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 02.02.2023.
//

import SwiftUI

struct TransactionsListView: View {
  @EnvironmentObject var authViewModel: UserViewModel
  
    var body: some View {
      VStack {
        ScrollView {
          ForEach(authViewModel.userCoins, id: \.self) { data in
              VStack(spacing: 3) {
                TransactionCell(id: data.id ?? UUID(), name: data.name ?? "", symbol: data.symbol ?? "", sum: data.sum, coinSum: data.currentPrice)
              }
              .padding(.horizontal, 10)
          }
        }
      }
      .background(Colors.lightBackground)
    }
}
