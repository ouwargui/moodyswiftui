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
  @Published var alertTitle = ""
  @Published var alertMessage = ""
  @Published var isAlertShowing = false
  @Published var isButtonLoading = false
  var isButtonDisabled: Bool {
    return isButtonLoading || email.isEmpty || password.isEmpty
  }

  func loginWithEmailAndPassword(authStore: AuthStore) async {
    do {
      try await authStore.loginWithEmailAndPassword(email: email, password: password)
    } catch {
      showAlert(title: "Error", message: error.localizedDescription)
    }
  }

  func loginWithGoogle(authStore: AuthStore) async {
    do {
      try await authStore.loginWithGoogle()
    } catch {
      showAlert(title: "Error", message: error.localizedDescription)
    }
  }

  func loginWithApple(authStore: AuthStore) async {
    authStore.loginWithApple { error in
      self.showAlert(title: "Error", message: error.localizedDescription)
    }
  }

  private func showAlert(title: String, message: String) {
    alertTitle = title
    alertMessage = message
    isAlertShowing = true
  }

  func dismissAlert() {
    alertTitle = ""
    alertMessage = ""
    isAlertShowing = false
  }
}
