//
//  ViewModifiers.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 07.02.2023.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding()
      .background(.white)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Colors.primaryGreen, lineWidth: 2)
      )
  }
}

struct PrimaryGreenButtonModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .foregroundColor(.white)
      .frame(width: UIScreen.main.bounds.width - 30, height: 38)
      .background(Colors.primaryGreen)
      .cornerRadius(4)
  }
}
