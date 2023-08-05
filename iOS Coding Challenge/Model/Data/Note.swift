//
//  Note.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 04/08/2023.
//

import Foundation

struct Note: Codable, Identifiable {
    let id: String?
    let content: String?
    let createDate: Date?
    let createBy: String?
    let timestamp: Double?
    let ownerId: String?
    
    
    var createDateString: String {
        get {
            return createDate?.toString(format: "HH:mm dd/MM/yyyy") ?? ""
        }
    }

    enum CodingKeys: String, CodingKey {
        case id = "key"
        case content
        case createDate = "create_date"
        case createBy = "create_by"
        case timestamp
        case ownerId = "owner_id"
    }
    
    func toDictionary() -> [String: Any] {
        let date = createDate ?? Date()
        return [
            "content": content ?? "",
            "create_date": date.toString(format: "yyyy-MM-dd'T'HH:mm:ss"),
            "create_by": createBy ?? "",
            "timestamp": timestamp ?? 0,
            "negative_timestamp": -(timestamp ?? 0),
            "owner_id": ownerId ?? ""
        ]
        
    }
}
