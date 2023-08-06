//
//  FirebaseDatabase.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 02/08/2023.
//

import Combine
import SwiftUI

class NoteStore: BaseObservableObject {
    @Published var allNoteState: DataState<[Note]> = .loading
    @Published var myNoteState: DataState<[Note]> = .loading
    private var allNotes: [Note] = []
    private var myNotes: [Note] = []
    private var repository: NotesRepositoryProtocol
    private var isLoadingPage = false
    private var canLoadMorePages = true
    
    init(repository: NotesRepositoryProtocol) {
        self.repository = repository
    }
    
    @MainActor func fetchAllNotes() {
        let task = Task {
            do {
                allNotes = try await repository.fecthAllNotes(pageSize: 20)
                allNoteState = .success(data: allNotes)
            } catch {
                allNoteState = .failed(err: error.localizedDescription)
            }
        }
        runTask(task)
    }
    
    @MainActor func loadMore(item: Note) {
        let thresholdIndex = allNotes.index(allNotes.endIndex, offsetBy: -5)
        if allNotes.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            loadMoreNotes()
        }
    }
    
    
    @MainActor func loadMoreNotes() {
        guard !isLoadingPage && canLoadMorePages else {
            return
        }
        guard let timestamp = allNotes.last?.timestamp else { return }
        isLoadingPage = true
        let task = Task {
            do {
                let notes = try await repository.loadmoreAllNotes(pageSize: 20, timestamp: -timestamp)
                canLoadMorePages = allNotes.count == 20
                allNotes.append(contentsOf: notes)
                allNoteState = .success(data: allNotes)
                isLoadingPage = false
            } catch {
                allNoteState = .failed(err: error.localizedDescription)
            }
        }
        runTask(task)
    }
    
    @MainActor func fetchAllMyNote(from account: Account) {
        let task = Task {
            do {
                myNotes = try await repository.fetchMyNotes(account: account)
                myNoteState = .success(data: myNotes)
            } catch {
                myNoteState = .failed(err: error.localizedDescription)
            }
        }
        runTask(task)
    }
    
    @MainActor func insertnToTop(note: Note) {
        myNotes.insert(note, at: 0)
        myNoteState = .success(data: myNotes)
        allNotes.insert(note, at: 0)
        allNoteState = .success(data: allNotes)
    }
    
    @MainActor func updateMyNote(note: Note) {
        if let index = allNotes.firstIndex(where: { $0.id == note.id }) {
            allNotes[index] = note
        }
        if let index = myNotes.firstIndex(where: { $0.id == note.id }) {
            myNotes[index] = note
        }
        myNoteState = .success(data: myNotes)
        allNoteState = .success(data: allNotes)
    }
}

