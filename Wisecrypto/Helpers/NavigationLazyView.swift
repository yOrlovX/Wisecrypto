//
//  NavigationLazyView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 04.02.2023.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
