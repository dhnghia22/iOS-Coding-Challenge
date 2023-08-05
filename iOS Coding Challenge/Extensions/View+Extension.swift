//
//  View.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 02/08/2023.
//

import SwiftUI

extension View {
    func customStyle() -> some View {
        self.modifier(CustomTextStyle())
    }
}

extension View {
    func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
}

extension View {
    func fontSize(_ size: FontSizeModifier.Size) -> some View {
        self.modifier(FontSizeModifier(size: size))
    }
}
