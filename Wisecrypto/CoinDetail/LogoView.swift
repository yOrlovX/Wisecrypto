//
//  LogoView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 27.02.2023.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
      VStack {
        Image("Logo")
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .frame(width: 100, height: 100)
        .foregroundColor(Colors.primaryGreen)
        .padding()
//        .clipShape(Capsule())
      }
      .background(.black)
      .clipShape(Capsule())
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
