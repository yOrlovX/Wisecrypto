//
//  PaymentView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 02.02.2023.
//

import SwiftUI

struct PaymentView: View {
  let payments = PaymentModel.paymentData
  
    var body: some View {
      List(payments) { payment in
        HStack {
          Image(payment.image)
            .resizable()
            .scaledToFit()
            .frame(width: 64, height: 64)
          
          VStack(alignment: .leading) {
            Text(payment.name)
              .font(.system(size: 20, weight: .bold))
            
            Text(payment.billNumber)
              .font(.system(size: 16, weight: .regular))
              .foregroundColor(.gray)
          }
        }
      }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}

struct PaymentModel: Identifiable {
  let id = UUID()
  let image: String
  let name: String
  let billNumber: String
  
  static let paymentData = [
    PaymentModel(image: "ovo", name: "OVO", billNumber: "081264950021"),
    PaymentModel(image: "goPay", name: "GOPAY", billNumber: "081264956578")
  ]
}
