//
//  AddBalanceView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 14.02.2023.
//


enum Payments: String, CaseIterable, Identifiable {
    case ovo
    case goPay
   
    var id: String { self.rawValue }
}

import SwiftUI

struct AddBalanceView: View {
    @Environment(\.presentationMode) var presentationMode
  //  @StateObject var portfolioViewModel = PortfolioViewModel()
  @State private var balance: String = ""
  let payments = PaymentModel.paymentData
  @State private var selectedPayment = Payments.ovo
  
  var body: some View {
    VStack(spacing: 50) {
      VStack {
        Text("Enter payment sum:")
        TextField("$", text: $balance)
          .font(.system(size: 52, weight: .bold))
          .padding()
          .font(.system(.subheadline))
          .frame(width: 160, height: 56)
          .modifier(TextFieldModifier())
      }
     
      VStack {
        Text("Select you payment method:")
        HStack(spacing: 10) {
          Picker("Flavor", selection: $selectedPayment) {
            ForEach(payments) { payment in
              HStack {
                Image(payment.image)
                Text(payment.name)
              }
            }
          }
          .padding()
          .foregroundColor(.black)
        }
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Colors.primaryGreen, lineWidth: 2)
        )
      }
      Button(action: {
        self.presentationMode.wrappedValue.dismiss()
      }) {
        Text("Fill up")
          .modifier(PrimaryGreenButtonModifier())
      }
    }
  }
}

struct AddBalanceView_Previews: PreviewProvider {
  static var previews: some View {
    AddBalanceView()
  }
}
