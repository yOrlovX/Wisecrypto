//
//  HomeView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 30.01.2023.
//

import SwiftUI

struct HomeView: View {
  
  @EnvironmentObject var coinsViewModel: CoinsViewModel
  @EnvironmentObject var userViewModel: UserViewModel
  @State var selection: String = ""
  @State private var hasAppeared = false
  var filterConditions = ["Rank", "Max", "Min", "Percentage"]
  
  var body: some View {
    NavigationView {
      ZStack {
        ScrollView {
          VStack(spacing: 20) {
            userSection
            totalPortfolioSection
            myCoinSection
            watchlistSection
          }
          .padding(.top, 30)
          .onAppear {
            if !hasAppeared {
//              authViewModel.getUserData()
              userViewModel.getPortfolioData()
              hasAppeared = true
            }
          }
        }
      }
      .background(Colors.lightBackground)
      .navigationBarHidden(true)
    }
  }
}

private extension HomeView {
  
  private var userSection: some View {
    HStack(spacing: 12) {
      if let userImageData = userViewModel.userData.last?.userImage,
         let userImage = UIImage(data: userImageData) {
        Image(uiImage: userImage)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 40, height: 40)
          .clipShape(Circle())
      } else {
        Image(systemName: "person.circle")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 40, height: 40)
      }
      VStack(alignment: .leading) {
        Text("Hello")
          .font(.system(size: 12, weight: .semibold))
          .foregroundColor(.gray)
        Text(userViewModel.savedInitials?.string ?? "No name")
          .font(.system(size: 20, weight: .bold))
      }
      Spacer()
      Picker("", selection: $selection) {
        ForEach(filterConditions, id: \.self) { item in
          Text(item)
        }
      }
      .pickerStyle(.menu)
      Button(action: { switchFilterButtonActions() }) {
        Image(systemName: "line.3.horizontal.decrease.circle.fill")
          .resizable()
          .scaledToFit()
          .frame(width: 24, height: 24)
      }
    }
    .padding(.horizontal, 15)
  }
  
  private var totalPortfolioSection: some View {
    Rectangle()
      .frame(width: UIScreen.main.bounds.width - 30, height: 112)
      .foregroundColor(Colors.primaryGreen)
      .cornerRadius(10)
      .overlay {
        HStack {
          VStack(alignment: .leading) {
            Text("Total Portofolio")
              .font(.system(size: 16, weight: .semibold))
              .foregroundColor(.white)
            Text("$ \(String(format:"%.2f",userViewModel.totalCoinsSum()))")
              .font(.system(size: 32, weight: .bold))
              .foregroundColor(.white)
          }
          Spacer()
          Rectangle()
            .frame(width: 55, height: 22)
            .foregroundColor(.white)
            .cornerRadius(8)
            .overlay {
              HStack(spacing: 2) {
                Image(systemName: userViewModel.portfolioCurrentPecentage() < 0 ? "chevron.down" : "chevron.up")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 6, height: 6)
                  .foregroundColor(userViewModel.portfolioCurrentPecentage() < 0 ? Colors.primaryRed : Colors.primaryGreen)
                  .padding(.vertical, 4)
                Text("\(String(format:"%.1f", userViewModel.portfolioCurrentPecentage()))%")
                  .font(.system(size: 10, weight: .bold))
                  .foregroundColor(userViewModel.portfolioCurrentPecentage() < 0 ? Colors.primaryRed : Colors.primaryGreen)
                  .padding(.vertical, 4)
              }
            }
        }
        .padding(.horizontal, 25)
      }
  }
  
  private var myCoinSection: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Text("My Coins")
          .font(.system(size: 14, weight: .semibold))
        Spacer()
        Text("See all")
          .font(.system(size: 12, weight: .bold))
          .foregroundColor(Colors.primaryGreen)
      }
      ScrollView(.horizontal) {
        HStack(spacing: 16) {
          ForEach(userViewModel.userCoins) { data in
            MyCoinsCell(entity: data)
          }
        }
      }
      .frame(height: 119)
    }
    .padding(.horizontal, 15)
  }
  
  private var watchlistSection: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("Watchlist")
        .font(.system(size: 14, weight: .semibold))
      ScrollView(.vertical, showsIndicators: true) {
        LazyVStack(spacing: 8) {
          ForEach(coinsViewModel.coinData) { data in
            NavigationLink {
              NavigationLazyView(CoinDetailView(coin: data))
            } label: {
              CoinCell(rowData: data)
            }
          }
        }
      }
    }
    .padding(.horizontal, 15)
  }
  
  private func switchFilterButtonActions() {
    switch selection {
    case "Rank":
      coinsViewModel.sortedByCoinRank()
    case "Max":
      coinsViewModel.sortByMaxPrice()
    case "Min":
      coinsViewModel.sortByMinPrice()
    case "Percentage":
      coinsViewModel.sortedByPercentChange()
    default:
      break
    }
  }
  
  struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
      HomeView()
        .environmentObject(CoinsViewModel())
    }
  }
}
