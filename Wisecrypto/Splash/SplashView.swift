//
//  SplashView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 30.01.2023.
//

import SwiftUI

struct SplashView: View {
  var body: some View {
    ZStack {
      Colors.backgroundGradient
        .ignoresSafeArea()
      VStack(spacing: 4) {
        HStack {
          Image("Logo")
            .resizable()
            .scaledToFit()
            .frame(width: 70, height: 70)
          Text("Wisecrypto")
            .font(.system(size: 35, weight: .bold))
            .foregroundColor(.white)
        }
        Text("Trusted by millions of users worldwide")
          .font(.system(size: 16, weight: .semibold))
          .foregroundColor(.white)
      }
    }
  }
}

struct SplashView_Previews: PreviewProvider {
  static var previews: some View {
    SplashView()
  }
}
