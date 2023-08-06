//
//  EditNoteView.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 05/08/2023.
//

import SwiftUI

struct EditNoteView: View {
    @ObservedObject var noteStore: NoteStore
    
    @EnvironmentObject var appStore: AppStore
    
    @StateObject var createNoteStore: CreateNoteStore = CreateNoteStore(repository: NoteFirebaseReposiory())
    @State private var noteString: String = ""
    @State private var alertMessage: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var note: Note?
    
    init(noteStore: NoteStore, note: Note? = nil) {
        self.noteStore = noteStore
        self.note = note
        _noteString = State(initialValue: note?.content ?? "")
    }
    
    private var isOwner: Bool {
        get {
            return appStore.account?.userKey != nil && appStore.account?.userKey == note?.ownerId
        }
    }
    
    private var isCreated: Bool {
        get {
            return note == nil
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                TextEditor(text: $noteString)
                    .padding()
                    .fontSize(.regular)
                    .border(Color.gray, width: 1)
                    .disabled(!isOwner && !isCreated)
                    .accessibility(identifier: "createNoteTextEditor")
                Spacer()
                if isCreated || isOwner {
                    AppButton(title: isCreated ? "Create" : "Update") {
                        createOrUpdateNote()
                    }
                }
            }.padding()
        }
        .onReceive(createNoteStore.$updateNoteState) { state in
            if case DataState.failed(let err) = state {
                alertMessage = err
            }
            if case DataState.success(let note) = state {
                // add Items to current list
                isCreated ? noteStore.insertnToTop(note: note) : noteStore.updateMyNote(note: note)
                alertMessage = isCreated ? "Create note successfuly" :  "Update note successfuly"
                presentationMode.wrappedValue.dismiss()
            }
        }
        .alert(isPresented: .constant(alertMessage.count > 0)) {
            Alert(title: Text("Alert"),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("OK")) {
                alertMessage = ""
            })
        }
        .navigationTitle(isCreated ? "Create Note" : "Update Note")
    }
    
    
    private func createOrUpdateNote() {
        if isCreated {
            guard let acc = appStore.account else { return }
            createNoteStore.createNote(from: acc, note: noteString)
        } else {
            guard let note = note else { return }
            createNoteStore.updateNote(curentNote: note, newNoteString: noteString)
        }
    }
}
