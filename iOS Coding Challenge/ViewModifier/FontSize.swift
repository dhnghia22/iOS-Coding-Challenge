//
//  FontSize.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 05/08/2023.
//

import Foundation
import SwiftUI

struct FontSizeModifier: ViewModifier {
    enum Size: CGFloat {
        case small = 12
        case regular = 14
        case medium = 16
        case large = 18
    }
    
    let size: Size

    func body(content: Content) -> some View {
        switch size {
        case .small:
            return content.font(.system(size: Size.small.rawValue))
        case .medium:
            return content.font(.system(size: Size.medium.rawValue))
        case .regular:
            return content.font(.system(size: Size.regular.rawValue))
        case .large:
            return content.font(.system(size: Size.large.rawValue))
        }
    }
}
