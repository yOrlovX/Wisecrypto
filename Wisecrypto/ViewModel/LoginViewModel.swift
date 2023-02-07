//
//  LoginViewModel.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 07.02.2023.
//

import SwiftUI

class LoginViewModel: ObservableObject {
  
  
  func isValidPassword(_ password: String) -> Bool {
    let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
    
    return passwordRegex.evaluate(with: password)

  }
}
