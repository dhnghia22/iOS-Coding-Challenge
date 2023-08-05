//
//  AuthView.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 02/08/2023.
//

import SwiftUI

struct AuthView: View {
    
    @StateObject var authStore = AuthStore(repository: AuthFireBaseRepository())
    @EnvironmentObject var appStore: AppStore
    @Environment(\.presentationMode) var presentationMode
    @State private var alertMessage: String = ""
    
    @State private var userNameString: String = ""
    var body: some View {
        NavigationView {
            VStack {
                Text("Please input your user name"
                ).fontSize(.medium)
                    .padding(EdgeInsets(top: 40, leading: 16, bottom: 8, trailing: 16))
                AppTextField(text: $userNameString)
                    .marginVertical(8)
                    .autocapitalization(.none)
                AppButton(title: "Submit") {
                    login()
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Login")
        }
        .onReceive(authStore.$account) { account in
            if let acc = account {
                appStore.updateAccount(account: acc)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .onReceive(authStore.$errorString) { err in
           alertMessage = err
        }
        .alert(isPresented: .constant(alertMessage.count > 0)) {
            Alert(title: Text("Error"),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("OK")) {
                      alertMessage = "" // Reset the alert message after the alert is dismissed
                  })
        }
    }
    
    private func login() {
        if (userNameString.count < 6) {
            alertMessage = "User name must be have 6 charactor"
            return
        }
        authStore.login(with: userNameString)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
