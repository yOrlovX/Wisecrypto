//
//  ProfileView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 02.02.2023.
//

import SwiftUI

enum ProfileLinksSwitcher {
  case Privacy
  case Notifications
  case nonSelected
}

struct ProfileView: View {
  private let sectionsData = ProfileCellModel.profileCellData
  var destination: ProfileLinksSwitcher = .nonSelected
  
  var body: some View {
    NavigationView {
      ZStack {
        Colors.lightBackground
          .ignoresSafeArea()
        VStack {
          Image("userImage")
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
          
          currentBalanceSection
          buttonsSections
            .offset(y: -30)
          
          VStack(spacing: 8) {
            ForEach(sectionsData) { data in
              NavigationLink {
                switch data.name {
                case "Privacy":
                  PrivacyView()
                case "Notifications":
                  ProfileNotificationsView()
                case "Payment":
                  PaymentView()
                case "Transaction List":
                  TransactionsListView()
                default:
                  EmptyView()
                }
              } label: {
                ProfileCell(image: data.image, name: data.name, description: data.description)
              }
            }
          }
        }
        .background(Colors.lightBackground)
      }
    }
  }
}

extension ProfileView {
  private var currentBalanceSection: some View {
    HStack {
      Rectangle()
        .frame(width: UIScreen.main.bounds.width - 30, height: 100)
        .foregroundColor(Colors.primaryGreen)
        .cornerRadius(10)
        .overlay {
          HStack {
            Text("Current Balance")
              .font(.system(size: 16, weight: .regular))
              .foregroundColor(.white)
              .padding()
            Spacer()
            Text("$25,000")
              .font(.system(size: 32, weight: .bold))
              .foregroundColor(.white)
              .padding()
          }
        }
    }
  }
  private var buttonsSections: some View {
    HStack {
      VStack {
        Image(systemName: "square.and.arrow.down")
          .resizable()
          .scaledToFit()
          .frame(width: 24, height: 24)
          .foregroundColor(Colors.primaryGreen)
        Text("Pull")
          .font(.system(size: 14, weight: .semibold))
          .foregroundColor(Colors.primaryGreen)
      }
      .padding(.vertical, 12)
      .padding(.horizontal, 40)
      Divider()
        .frame(height: 35)
        .background(Colors.primaryGreen)
      VStack {
        Image(systemName: "plus.app")
          .resizable()
          .scaledToFit()
          .frame(width: 24, height: 24)
          .foregroundColor(Colors.primaryGreen)
        Text("Add")
          .font(.system(size: 14, weight: .semibold))
          .foregroundColor(Colors.primaryGreen)
      }
      .padding(.vertical, 12)
      .padding(.horizontal, 40)
    }
    .background(.white)
    .cornerRadius(16)
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
