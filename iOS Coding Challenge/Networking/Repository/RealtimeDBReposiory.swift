//
//  RealtimeDBReposiory.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 02/08/2023.
//

import Foundation

class NoteFirebaseReposiory: NotesRepositoryProtocol  {
    func fecthAllNotes(pageSize: UInt) async throws -> [Note] {
        return try await FirebaseNoteService.getAllNotes(limit: pageSize)
    }
    
    func fetchMyNotes(account: Account) async throws -> [Note] {
        return try await FirebaseNoteService.getNoteFrom(account: account)
    }
    
    func loadmoreAllNotes(pageSize: UInt, timestamp: Double) async throws -> [Note] {
        return try await FirebaseNoteService.loadMoreAllNote(limit: pageSize, value: timestamp)
    }
    
    func createNote(from account: Account, note: String) async throws -> Note {
        return try await FirebaseNoteService.write(from: note, account: account)
    }
    
    func updateNote(currentNote: Note, note: String) async throws -> Note {
        return try await FirebaseNoteService.update(from: currentNote, newNote: note)
    }
}

class AuthFireBaseRepository: AuthRepositoryProtocol {
    func signUp(userName: String) async throws -> Account {
        return try await FirebaseAuthService.signUp(with: userName)
    }
    
    func login(userName: String) async throws -> Account {
        return try await FirebaseAuthService.login(with: userName)
    }
    
}
