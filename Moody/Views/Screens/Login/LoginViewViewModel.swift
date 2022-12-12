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
  @Published var isButtonLoading = false
  var isButtonDisabled: Bool {
    return isButtonLoading || email.isEmpty || password.isEmpty
  }
  
  func login(userStore: UserStore) async {
    do {
      isButtonLoading = true
      try await userStore.login(email: email, password: password)
      isButtonLoading = false
    } catch {
      print(error.localizedDescription)
      isButtonLoading = false
    }
  }
}
