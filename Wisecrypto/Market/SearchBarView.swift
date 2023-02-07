//
//  SearchBarView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 07.02.2023.
//

import SwiftUI

struct SearchBarView: View {
  @Binding var searchText: String
  
    var body: some View {
      HStack {
        Image(systemName: "magnifyingglass")
          .foregroundColor(Colors.primaryGreen)
        
        TextField("Search by symbol", text: $searchText)
          .disableAutocorrection(true)
          .overlay(
            Image(systemName: "xmark.circle.fill")
              .padding()
              .offset(x: 10)
              .foregroundColor(Colors.primaryGreen)
              .opacity(searchText.isEmpty ? 0.0 : 1.0)
              .onTapGesture {
                UIApplication.shared.endEditing()
                searchText = ""
              }
            , alignment: .trailing
          )
      }
      .font(.headline)
      .padding()
      .background(
      RoundedRectangle(cornerRadius: 25)
        .fill(.white)
        .shadow(color: Colors.primaryGreen.opacity(0.15),
                radius: 10, x: 0, y: 0)
      )
      .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
      SearchBarView(searchText: .constant(""))
        .previewLayout(.sizeThatFits)
    }
}
