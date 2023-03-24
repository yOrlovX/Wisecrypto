//
//  ProfileView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 02.02.2023.
//

import SwiftUI

struct ProfileView: View {
  @State private var showLogoutAlert = false
  @State private var showImagePicker: Bool = false
  @State var isPresented: Bool = false
  
  private let sectionsData = ProfileCellModel.profileCellData
  private let logoutData = ProfileCellModel.logoutData
  
  @EnvironmentObject var portfolioViewModel: PortfolioViewModel
  @EnvironmentObject var authViewModel: UserViewModel
  
  var body: some View {
    NavigationView {
      ZStack(alignment: .top) {
        Colors.lightBackground
          .ignoresSafeArea()
        ScrollView {
          VStack {
            if let userImageData = portfolioViewModel.userData.last?.userImage,
               let userImage = UIImage(data: userImageData) {
              Image(uiImage: userImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .onTapGesture {
                  showImagePicker.toggle()
                }
            } else {
              Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .onTapGesture {
                  showImagePicker.toggle()
                }
            }
            
            if let user = authViewModel.currentUser {
              Text(user.fullName ?? "")
                .font(.system(size: 20, weight: .bold))
            }
            currentBalanceSection
            buttonsSections
              .offset(y: -30)
            VStack(spacing: 8) {
              ForEach(sectionsData) { data in
                NavigationLink {
                  NavigationLazyView(returnSelectView(name: ProfileLinksSwitcher(rawValue: data.name) ?? .nonSelected))
                } label: {
                  ProfileCell(image: data.image, name: data.name, description: data.description)
                }
              }
              ProfileCell(image: logoutData.image, name: logoutData.name, description: logoutData.description)
                .onTapGesture {
                  showLogoutAlert = true
                }
                .alert("Are you sure you want to leave?", isPresented: $showLogoutAlert) {
                  Button("OK", role: .cancel) { authViewModel.userLogin = false }
                  Button("Cancel", role: .destructive) {}
                }
            }
          }
          .background(Colors.lightBackground)
          .padding(.top, 40)
        }
      }
      .fullScreenCover(isPresented: $showImagePicker, onDismiss: didDismiss, content: {
        PhotoPicker(viewModel: portfolioViewModel)
      })
      .navigationBarHidden(true)
      .onAppear(perform: {
        portfolioViewModel.getUserData()
      })
    }
  }
  
  func didDismiss() {
    portfolioViewModel.getUserData()
  }
}

private extension ProfileView {
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
            Text("$ \(String(format:"%.2f",portfolioViewModel.getUserBalance()))")
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
      NavigationLink {
        NavigationLazyView(AddBalanceView())
      } label: {
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
    }
    .background(.white)
    .cornerRadius(16)
  }
  
  @ViewBuilder
  func returnSelectView(name: ProfileLinksSwitcher) -> some View {
    switch name {
    case .transactions:
      TransactionsListView()
    case .privacy:
      PrivacyView()
    case .payment:
      PaymentView()
    case .notifications:
      ProfileNotificationsView()
    default:
      EmptyView()
    }
  }
}
