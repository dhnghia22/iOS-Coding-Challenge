//
//  Text.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 02/08/2023.
//

import SwiftUI

struct CustomTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.red)
    }
}
