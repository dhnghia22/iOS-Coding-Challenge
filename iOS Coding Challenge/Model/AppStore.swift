//
//  AccountStore.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 03/08/2023.
//

import Foundation
import SwiftUI

class AppStore: ObservableObject {
    @Published var account: Account?
    
    func updateAccount(account: Account) {
        self.account = account
    }
    
    var isLogin: Bool {
        get {
            return account != nil
        }
    }
}
