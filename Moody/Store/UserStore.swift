//
//  UserStore.swift
//  Moody
//
//  Created by Guilherme Santos on 07/12/22.
//

import FirebaseAuth
import Foundation

enum AuthErrors: Error {
  case badEmail
  case badPassword
  case firebaseError
}

@MainActor
class UserStore: ObservableObject {
  @Published var isLoggedIn: Bool = false
  @Published var user: UserProfile?

  let authService = AuthService()

  func login(email: String, password: String) async throws {
    do {
      if email.isEmpty { throw AuthErrors.badEmail }
      if password.isEmpty { throw AuthErrors.badPassword }

      guard let user = try await self.authService.loginWithEmailAndPassword(email: email, password: password) else { return }

      self.user = UserProfile(
        email: user.email ?? "",
        name: user.displayName ?? "",
        photoUrl: user.photoURL,
        firebaseUser: user
      )
      self.isLoggedIn = true
    } catch {
      print(error.localizedDescription)
      throw AuthErrors.firebaseError
    }
  }

  func logout() throws {
    do {
      try self.authService.logout()
      self.isLoggedIn = false
    } catch {
      print(error.localizedDescription)
      throw AuthErrors.firebaseError
    }
  }
}
