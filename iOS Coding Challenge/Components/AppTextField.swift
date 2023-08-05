//
//  AppTextField.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 04/08/2023.
//

import SwiftUI

struct AppTextField: View {
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        TextField("Enter text here", text: $text)
            .frame(height: 40)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .cornerRadius(20)
    }
}
