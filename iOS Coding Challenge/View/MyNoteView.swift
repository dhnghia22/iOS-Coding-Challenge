//
//  MyNoteView.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 05/08/2023.
//

import SwiftUI

struct MyNoteView: View {
    @ObservedObject var noteStore: NoteStore
    @EnvironmentObject var appStore: AppStore
    @EnvironmentObject var appRoute: AppRoute
    @State private var isLinkActive = false
    
    var body: some View {
        Group {
            if let _ = appStore.account {
                loggedInView()
            } else {
                notLoggedInView()
            }
        }
        .navigationBarTitle(appStore.account?.userName ?? "My Notes", displayMode: .inline)
        .navigationBarItems(
            trailing: Button(action: {
                appStore.logOut()
            }, label: {
                Image(systemName: "person.crop.circle.badge.minus")
            }).opacity(appStore.account == nil ? 0 : 1.0 )
        )
        .navigationBarItems(
            trailing: NavigationLink(destination: appRoute.getScreen(from: .noteDetail(note: nil, store: noteStore)), isActive: $isLinkActive, label: {
                Button(action: {
                    isLinkActive = true
                }, label: {
                    Image(systemName: "plus.circle.fill")
                }).opacity(appStore.account == nil ? 0 : 1.0 )
            })
        )
        .onViewDidLoad {
            fecthNotes()
        }
        .onReceive(appStore.$account) { _ in
            fecthNotes()
        }
        
    }
    
    private func fecthNotes() {
        guard let acc = appStore.account else { return }
        noteStore.fetchAllMyNote(from: acc)
    }
    
    @ViewBuilder
    private func loggedInView() -> some View {
        VStack {
            switch noteStore.myNoteState {
            case .loading:
                ProgressView("Loading your notes...")
            case .success(let data):
                if data.count == 0 {
                    Text("Empty Note").fontSize(.regular)
                } else {
                    List {
                        ForEach(data) { element in
                            NoteItemView(store: noteStore, item: element)
                        }
                    }
                    .listStyle(.plain)
                    .accessibility(identifier: "myNotes")
                }
            case .failed(let err):
                Text("Failed to fetch notes: \(err)")
            }
        }
    }
    
    @ViewBuilder
    private func notLoggedInView() -> some View {
        VStack {
            Text("Login required").fontSize(.medium)
            AppButton(title: "Login") {
                appRoute.openAuthView()
            }
        }.padding()
    }
}
