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
      Text("Home")
        .tabItem {
          Label("Home", systemImage: "house")
        }
      Text("Market")
        .tabItem {
          Label("Market", systemImage: "cart")
        }
      Text("Profile")
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
