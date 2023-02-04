//
//  ProfileCell.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 02.02.2023.
//

import SwiftUI

struct ProfileCell: View {
  
  let image: String
  let name: String
  let description: String
  
  var body: some View {
    VStack {
      HStack(spacing: 8) {
        Image(image)
          .resizable()
          .scaledToFit()
          .frame(width: 44, height: 44)
        VStack(alignment: .leading) {
          Text(name)
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.black)
          Text(description)
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(.gray)
        }
        Spacer()
        Image(systemName: "chevron.right")
          .resizable()
          .scaledToFit()
          .frame(width: 8, height: 15)
          .foregroundColor(.gray)
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 12)
      .background(.white)
      .cornerRadius(10)
    }
    .padding(.horizontal, 15)
  }
}

struct ProfileCellModel: Identifiable {
  let id = UUID()
  let image: String
  let name: String
  let description: String
  
  static var profileCellData: [ProfileCellModel] = [
    ProfileCellModel(image: "list", name: "Transaction List", description: "Your Transactions"),
    ProfileCellModel(image: "privacy", name: "Privacy", description: "Change email and password"),
    ProfileCellModel(image: "wallet", name: "Payment", description: "Update payment settings"),
    ProfileCellModel(image: "bell", name: "Notifications", description: "Change notification settings")
  ]
  static var logoutData: ProfileCellModel = ProfileCellModel(image: "logout", name: "Logout", description: "Exit the application")
}

struct ProfileCell_Previews: PreviewProvider {
  static var previews: some View {
    ProfileCell(image: "privacy", name: "Privasi", description: "Ubah email dan password")
      .previewLayout(.sizeThatFits)
  }
}
