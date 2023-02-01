//
//  Colors.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 30.01.2023.
//

import Foundation
import SwiftUI

struct Colors {
  static let primaryGreen = Color("primaryGreen")
  static let primaryYellow = Color("primaryYellow")
  static let bgGreenGradient = Color("bgGreenGradient")
  static let bgBlueGradient = Color("bgBlueGradient")
  static let textGray = Color("textGray")
  static let primaryRed = Color("primaryRed")
  static let lightBackground = Color("lightBackground")
  static let backgroundGradient = LinearGradient(colors: [Colors.bgGreenGradient, Colors.bgBlueGradient], startPoint: .top, endPoint: .bottom)
}
