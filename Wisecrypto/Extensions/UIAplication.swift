//
//  UIAplication.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 07.02.2023.
//

import Foundation
import SwiftUI

extension UIApplication {
  
  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
