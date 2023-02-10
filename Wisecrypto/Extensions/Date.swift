//
//  Date.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 10.02.2023.
//

import Foundation

extension Date {
  
  init(apiString: String) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date = formatter.date(from: apiString) ?? Date()
    self.init(timeInterval: 0, since: date)
  }
  
  private var shortFormat: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
  }
  
  func shortDate() -> String {
    return shortFormat.string(from: self)
  }
}
