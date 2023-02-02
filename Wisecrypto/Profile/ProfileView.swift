//
//  ProfileView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 02.02.2023.
//

import SwiftUI

struct ProfileView: View {
  let sectionsData = ProfileCellModel.profileCellData
    
  var body: some View {
      VStack {
        Image("userImage")
          .resizable()
          .scaledToFit()
          .frame(width: 80, height: 80)
        
        VStack(spacing: 8) {
          ForEach(sectionsData) { data in
            ProfileCell(image: data.image, name: data.name, description: data.description)
          }
        }
      }
      .background(Colors.lightBackground)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
