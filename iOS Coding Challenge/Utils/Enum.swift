//
//  Enum.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 04/08/2023.
//

import Foundation

enum DataState<T> {
    case loading
    case success(data: T)
    case failed(err: String)
}

