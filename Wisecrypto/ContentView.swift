//
//  ContentView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 30.01.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      ZStack {
        Image("Logo")
          .resizable()
          .scaledToFit()
          .frame(width: 70, height: 70)
          .foregroundColor(Colors.primaryGreen)
        .padding()
      }
      .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
      .background(Colors.backgroundGradient)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
