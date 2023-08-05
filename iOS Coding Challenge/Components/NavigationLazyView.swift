//
//  NavigationLazyView.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 05/08/2023.
//

import Foundation
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
