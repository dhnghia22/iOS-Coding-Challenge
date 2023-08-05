//
//  OperationQueue+Extension.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 04/08/2023.
//

import Foundation

// Check MainThread
extension OperationQueue {
    static func mainQueueChecker() -> String {
        return Self.current == Self.main ? "✅" : "❌"
    }
    
    static func checkMainThread() {
        debugPrint("🔵 # - MainThread is \(OperationQueue.mainQueueChecker())")
    }
}
