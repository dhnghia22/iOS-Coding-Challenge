//
//  DebugHelper.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 05/08/2023.
//

import Foundation
import SwiftUI

public extension ShapeStyle where Self == Color {
    static var debug: Color {
        #if DEBUG
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
        #else
        return Color(.clear)
        #endif
    }
}
