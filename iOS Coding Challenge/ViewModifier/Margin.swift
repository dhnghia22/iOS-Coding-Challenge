//
//  HorizontalMargin.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 03/08/2023.
//

import Foundation
import SwiftUI

struct HorizontalMarginModifier: ViewModifier {
    let margin: CGFloat

    func body(content: Content) -> some View {
        content.padding(.horizontal, margin)
    }
}

struct VerticalMarginModifier: ViewModifier {
    let margin: CGFloat

    func body(content: Content) -> some View {
        content.padding(.vertical, margin)
    }
}

extension View {
    func marginHorizontal(_ margin: CGFloat = 16) -> some View {
        self.modifier(HorizontalMarginModifier(margin: margin))
    }
    
    func marginVertical(_ margin: CGFloat = 16) -> some View {
        self.modifier(VerticalMarginModifier(margin: margin))
    }
}
