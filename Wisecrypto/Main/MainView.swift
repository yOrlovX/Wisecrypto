//
//  MainView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 02.02.2023.
//

import SwiftUI

struct MainView: View {
  var body: some View {
    TabView {
      HomeView()
        .tabItem {
          Label("Home", systemImage: "house")
        }
      MarketView()
        .tabItem {
          Label("Market", systemImage: "cart")
        }
      ProfileView()
        .tabItem {
          Label("Profile", systemImage: "person")
        }
    }
    .accentColor(Colors.primaryGreen)
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
