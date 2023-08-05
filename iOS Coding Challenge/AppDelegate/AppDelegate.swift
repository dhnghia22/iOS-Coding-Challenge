//
//  AppDelegate.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 02/08/2023.
//

import Foundation
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        AppConfig.config();
        return true
    }
}
