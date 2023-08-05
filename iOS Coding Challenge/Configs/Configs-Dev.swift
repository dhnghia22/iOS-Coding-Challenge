//
//  Configs-Dev.swift
//  iOS Coding Challenge (Dev)
//
//  Created by Nghia Dinh on 02/08/2023.
//

import Foundation
import FirebaseCore

struct AppConstants {
    static let baseUrl = "https://todo.xyz"
}

struct AppConfig {
    static func config() {
        FirebaseApp.configure()
    }
}
