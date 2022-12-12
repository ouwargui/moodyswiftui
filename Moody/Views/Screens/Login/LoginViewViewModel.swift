//
//  LoginViewViewModel.swift
//  Moody
//
//  Created by Guilherme Santos on 12/12/22.
//

import Foundation

@MainActor
class LoginViewViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  
  func login(userStore: UserStore) async {
    do {
      try await userStore.login(email: email, password: password)
    } catch {
      print(error.localizedDescription)
    }
  }
}
