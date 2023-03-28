//
//  SplashView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 30.01.2023.
//

import SwiftUI

struct SplashView: View {
  
  let coinsViewModel: CoinsViewModel
  let authViewModel: AuthViewModel
  
  @State private var isActive: Bool = false
  @State private var opacity = 0.0
  @State private var rightOffset: CGFloat = 270
  @State private var leftOffset: CGFloat = -270
  @State private var scaleSize = 0.5
  
  init() {
    coinsViewModel = .init()
    authViewModel = .init()
  }
  
  var body: some View {
    ZStack {
      if isActive {
        AuthView()
      } else {
        splashState
      }
    }
    .environmentObject(coinsViewModel)
    .environmentObject(authViewModel)
  }
}


private extension SplashView {
  private var splashState: some View {
    ZStack {
      Colors.backgroundGradient
        .ignoresSafeArea()
      VStack(spacing: 4) {
        HStack {
          Image("Logo")
            .resizable()
            .scaledToFit()
            .frame(width: 70, height: 70)
            .opacity(opacity)
            .scaleEffect(scaleSize)
          Text("Wisecrypto")
            .font(.system(size: 35, weight: .bold))
            .foregroundColor(.white)
            .offset(x: rightOffset)
        }
        Text("Trusted by millions of users worldwide")
          .font(.system(size: 16, weight: .semibold))
          .foregroundColor(.white)
          .offset(x: leftOffset)
      }
    }
    .onAppear {
      withAnimation(.easeIn(duration: 2)){
        opacity = 1
        rightOffset = 0
        leftOffset = 0
        scaleSize = 1
      }
      DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
        self.isActive = true
      }
    }
  }
}

struct SplashView_Previews: PreviewProvider {
  static var previews: some View {
    SplashView()
  }
}
