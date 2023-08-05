//
//  Array+Extension.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 04/08/2023.
//

import Foundation

extension Array where Element == [String: Any] {
    func decodeArray<T: Decodable>(as type: T.Type, dateDecodingFormat: String = "yyyy-MM-dd'T'HH:mm:ss") -> [T] {
        do {
            let decoder = JSONDecoder()
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            return try decoder.decode([T].self, from: jsonData)
        } catch {
            debugPrint("Error decoding JSON: \(error)")
            return []
        }
    }
}
