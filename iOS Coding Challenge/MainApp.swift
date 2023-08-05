//
//  MainApp.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 02/08/2023.
//

import SwiftUI

@main
struct MainApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var appStore = AppStore()
    @StateObject var appRoute = AppRoute()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .sheet(isPresented: $appRoute.openAuth, content: {
                    AuthView()
                })
                .environmentObject(appStore)
                .environmentObject(appRoute)
        }
    }
}
