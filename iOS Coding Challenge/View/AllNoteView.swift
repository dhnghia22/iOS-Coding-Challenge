//
//  AllNoteView.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 05/08/2023.
//

import SwiftUI

struct AllNoteView: View {
    @ObservedObject var noteStore: NoteStore
    
    var body: some View {
        VStack {
            switch noteStore.allNoteState {
            case .loading:
                ProgressView("Loading all notes...")
            case .success(let data):
                List(data) { note in
                    NoteItemView(store: noteStore, item: note)
                        .onAppear {
                            noteStore.loadMore(item: note)
                        }
                }
                .listStyle(.plain)
                .accessibility(identifier: "noteList")
            case .failed(let err):
                Text("Failed to fetch notes: \(err)")
            }
        }.onViewDidLoad(perform: {
            noteStore.fetchAllNotes()
        })
        .navigationTitle("All Notes")
    }
}

struct NoteItemView: View {
    @EnvironmentObject var appRoute: AppRoute
    @ObservedObject var store: NoteStore
    var item: Note
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.createDateString).fontSize(.small)
                Text(item.content ?? "")
                    .fontSize(.regular)
                    .lineLimit(1)
                HStack {
                    Text(item.createBy ?? "")
                        .foregroundColor(.gray)
                        .fontSize(.small)
                        .padding(.trailing, 16)
                    Spacer()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
            NavigationLink(destination: NavigationLazyView(appRoute.getScreen(from: .noteDetail(note: item, store: store)))) {
                EmptyView()
            }.opacity(0)
        }
    }
}

