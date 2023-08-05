//
//  AuthStore.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 03/08/2023.
//

import Foundation



class AuthStore: BaseObservableObject {
    @Published var account: Account?
    @Published var errorString = ""
    var repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    

    @MainActor func login(with userName: String) {
        Task {
            do {
                let account = try await repository.login(userName: userName)
                self.account = account
            } catch {
                if case FirebaseError.userInvalid = error {
                    self.register(with: userName)
                } else {
                    errorString = error.localizedDescription
                }
            }
        }
    }
    
    @MainActor func register(with userName: String) {
        Task {
            do {
                let accout = try await repository.signUp(userName: userName)
                self.account = accout
            } catch {
                errorString = error.localizedDescription
            }
        }
    }
}
