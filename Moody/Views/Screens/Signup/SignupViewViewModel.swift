//
//  SignupViewViewModel.swift
//  Moody
//
//  Created by Guilherme Santos on 19/12/22.
//

import Foundation

@MainActor
class SignupViewViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var passwordConfirmation = ""
  @Published var alertTitle = ""
  @Published var alertMessage = ""
  @Published var isAlertShowing = false
  @Published var isButtonLoading = false
  var isButtonDisabled: Bool {
    return isButtonLoading || email.isEmpty || password.isEmpty || password != passwordConfirmation
  }

  func dismissAlert() {
    alertTitle = ""
    alertMessage = ""
    isAlertShowing = false
  }

  func signup(authStore: AuthStore) async {
    do {
      isButtonLoading = true
      try await authStore.signup(email: email, password: password)
      try await authStore.loginWithEmailAndPassword(email: email, password: password)
      isButtonLoading = false
    } catch {
      alertTitle = "Error"
      alertMessage = error.localizedDescription
      isAlertShowing = true
      isButtonLoading = false
    }
  }
}
