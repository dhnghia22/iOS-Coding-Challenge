//
//  Account.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 03/08/2023.
//

import Foundation

struct Account {
    let userName: String
    let userKey: String
    let noteIds: [String]
}

extension Account {
    init(from queryResult: [String: Any]) {
        let key = queryResult.keys.first ?? ""
        let dic = queryResult[key] as? [String: Any]
        userKey = key
        userName = dic?["username"] as? String ?? ""
        noteIds = dic?["notes"] as? [String] ?? []
    }
}



