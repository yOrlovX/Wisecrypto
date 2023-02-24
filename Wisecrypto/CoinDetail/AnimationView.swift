//
//  AnimationView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 22.02.2023.
//

import SwiftUI

struct AnimationView: View {
  @State private var yOffset: CGFloat = 0
  @State private var opacity: Double = 1
  @State private var emojiOpacity: Double = 0
  @State private var rotationEffect: Double = 0
  
  var body: some View {
    VStack(spacing: 30) {
      HStack {
        Image("goldCoin")
          .resizable()
          .scaledToFit()
          .foregroundColor(Colors.primaryGreen)
          .frame(width: 100, height: 100)
          .offset(y: yOffset)
          .opacity(opacity)
          .rotationEffect(Angle.degrees(rotationEffect))
      }
      Image("creditCard")
        .resizable()
        .scaledToFit()
        .cornerRadius(20)
        .frame(width: 200, height: 200)
    }
    .onAppear {
      withAnimation(.linear(duration: 1.5)) {
        yOffset = 170
      }
      withAnimation(.easeInOut(duration: 2)) {
        emojiOpacity = 1
        rotationEffect = 360
      }
    }
  }
}

struct AnimationView_Previews: PreviewProvider {
  static var previews: some View {
    AnimationView()
  }
}
