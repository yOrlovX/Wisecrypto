//
//  WisecryptoApp.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 30.01.2023.
//

import SwiftUI

@main
struct WisecryptoApp: App {
  
  init() {
    UIScrollView.appearance().keyboardDismissMode = .onDrag
  }
    
  var body: some Scene {
        WindowGroup {
          AuthView()
        }
    }
}
