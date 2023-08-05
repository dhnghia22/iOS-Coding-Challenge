//
//  Config-Prod.swift
//  iOS Coding Challenge (Prod)
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

