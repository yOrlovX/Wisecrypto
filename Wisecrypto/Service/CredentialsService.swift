//
//  CredentialsService.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 29.03.2023.
//

import Foundation

final class CredentialsService {
  
   func isValidEmail(email: String) -> Bool {
    let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
    return regex.firstMatch(in: email, range: NSRange(location: 0, length: email.count)) != nil
  }
  
   func isValidPassword(_ password: String) -> Bool {
    let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
    return passwordRegex.evaluate(with: password)
  }
}
