//
//  AppRoute.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 05/08/2023.
//

import Foundation
import SwiftUI

enum Route {
    case noteDetail(note: Note?, store: NoteStore)
}


class AppRoute: ObservableObject {
    @Published var openAuth: Bool = false
    
    func openAuthView() {
        openAuth = true
    }
    
    
    func getScreen(from route: Route) -> some View {
        switch route {
        case .noteDetail(let note, let store):
            return EditNoteView(noteStore: store, note: note)
        }
    }
}
