//
//  TransactionCell.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 28.02.2023.
//

import SwiftUI

struct TransactionCell: View {
  let id: UUID
  let name: String
  let symbol: String
  let sum: Double
  let coinSum: Double
  
    var body: some View {
      VStack {
        HStack {
          VStack(alignment: .leading, spacing: 5) {
            Text("Operation ID:")
              .font(.system(size: 12, weight: .semibold))
            Text("\(id)")
              .font(.system(size: 12, weight: .semibold))
          }
          Spacer()
          Rectangle()
            .frame(width: 62, height: 23)
            .foregroundColor(Colors.primaryGreen)
            .cornerRadius(10)
            .overlay {
              Text("BUY")
                .font(.system(size: 12, weight: .regular))
            }
        }
        .padding(.horizontal)
        Divider()
        HStack {
          VStack(alignment: .leading, spacing: 5) {
            Text(name)
              .font(.system(size: 16, weight: .bold))
            Text("$ \(String(format: "%.2f", sum))")
              .font(.system(size: 16, weight: .bold))
            Text("\(symbol.uppercased()) \(String(format: "%.4f", sum / coinSum))")
              .font(.system(size: 16, weight: .bold))
          }
          Spacer()
          Text("\(Date.now.shortDate())")
        }
        .padding(.horizontal)
      }
      .padding(10)
      .background(.white)
      .cornerRadius(20)
    }
}

struct TransactionCell_Previews: PreviewProvider {
    static var previews: some View {
      TransactionCell(id: UUID(), name: "COin", symbol: "BTS", sum: 100, coinSum: 300)
    }
}
