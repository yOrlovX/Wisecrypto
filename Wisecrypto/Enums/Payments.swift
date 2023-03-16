//
//  Payments.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 16.03.2023.
//

import Foundation

enum Payments: String, CaseIterable, Identifiable {
    case ovo
    case goPay
    var id: String { self.rawValue }
}
