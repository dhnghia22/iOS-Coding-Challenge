//
//  Date+Extension.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 04/08/2023.
//

import Foundation

import Foundation

extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    static func fromString(_ dateString: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString)
    }
}

