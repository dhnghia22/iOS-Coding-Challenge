//
//  CreateNoteStore.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 05/08/2023.
//

import Foundation

class CreateNoteStore: BaseObservableObject {
    @Published var updateNoteState: DataState<Note> = .loading
    private var repository: NotesRepositoryProtocol
    
    init(repository: NotesRepositoryProtocol) {
        self.repository = repository
    }
    
    @MainActor func createNote(from account: Account, note: String) {
        let task = Task {
            if (note.count == 0) {
                updateNoteState = .failed(err: "Please input note")
                return
            }
            do {
                let note = try await repository.createNote(from: account, note: note)
                updateNoteState = .success(data: note)
            } catch {
                updateNoteState = .failed(err: error.localizedDescription)
            }
        }
        runTask(task)
    }
    
    @MainActor func updateNote(curentNote: Note, newNoteString: String) {
        let task = Task {
            if (newNoteString.count == 0) {
                updateNoteState = .failed(err: "Please input note")
                return
            }
            do {
                let note = try await repository.updateNote(currentNote: curentNote, note: newNoteString)
                updateNoteState = .success(data: note)
            } catch {
                updateNoteState = .failed(err: error.localizedDescription)
            }
        }
        runTask(task)
    }
}
