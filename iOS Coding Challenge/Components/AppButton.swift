//
//  AppButton.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 03/08/2023.
//

import Foundation
import SwiftUI

struct AppButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 40)
            .padding(.horizontal, 20)
            .foregroundColor(.white)
            .background(Color.primary)
            .cornerRadius(20)
        
    }
}

struct AppButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title).frame(maxWidth: .infinity)
        }
        .buttonStyle(AppButtonStyle())
    }
}
