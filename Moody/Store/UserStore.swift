//
//  UserStore.swift
//  Moody
//
//  Created by Guilherme Santos on 07/12/22.
//

import Foundation

class UserStore: ObservableObject {
  @Published var isLoggedIn: Bool = false

  func login() {
    self.isLoggedIn = true
  }

  func logout() {
    self.isLoggedIn = false
  }
}
