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
}
