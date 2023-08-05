//
//  HomeView.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 05/08/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var appRoute = AppRoute()
    @StateObject var noteStore = NoteStore(repository: NoteFirebaseReposiory())
    
    var body: some View {
        TabView {
            NavigationView {
                AllNoteView(noteStore: noteStore)
            }
            .tabItem {
                Image(systemName: "doc.text")
                Text("All Notes")
            }
            .tag(0)
            NavigationView {
                MyNoteView(noteStore: noteStore)
            }
            .tabItem {
                Image(systemName: "person.crop.circle")
                Text("My Notes")
            }
            .tag(1)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
