//
//  Dictionary+Extension.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 04/08/2023.
//

import Foundation

extension Dictionary {
    func decodeJSON<T: Decodable>(as type: T.Type) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: self, options: [])
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }
}
