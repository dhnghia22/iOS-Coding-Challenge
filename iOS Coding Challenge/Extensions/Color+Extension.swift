//
//  Color+Extension.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 04/08/2023.
//


import SwiftUI

extension Color {
    static let primary = Color(hex: 0x5865EF, alpha: 1) // Primary color defined in Assets.xcassets
    static let secondary =  Color(hex: 0x5865EF, alpha: 1)  // Secondary color defined in Assets.xcassets
    
    static func randomColor() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
    
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

