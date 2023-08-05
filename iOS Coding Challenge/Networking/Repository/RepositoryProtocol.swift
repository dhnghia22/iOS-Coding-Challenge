//
//  RepositoryProtocol.swift
//  iOS Coding Challenge (Dev)
//
//  Created by Nghia Dinh on 02/08/2023.
//

import Foundation

protocol NotesRepositoryProtocol {
    func fecthAllNotes(pageSize: UInt) async throws -> [Note]
    func loadmoreAllNotes(pageSize: UInt, timestamp: Double) async throws -> [Note]
    func fetchMyNotes(account: Account) async throws -> [Note]
    func createNote(from account: Account, note: String) async throws -> Note
    func updateNote(currentNote: Note, note: String) async throws -> Note
}

protocol AuthRepositoryProtocol {
    func login(userName: String) async throws -> Account
    func signUp(userName: String) async throws -> Account
}


