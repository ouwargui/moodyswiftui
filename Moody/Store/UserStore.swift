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
  enum LoginState {
    case signedInWithGoogle
    case signedInWithApple
    case signedInWithEmail
    case signedOut
  }

  @Published var loginState: LoginState = .signedOut
  @Published var user: UserProfile?

  let authService = AuthService()

  func login(email: String, password: String) async throws {
    do {
      if email.isEmpty { throw AuthErrors.badEmail }
      if password.isEmpty { throw AuthErrors.badPassword }

      guard let user = try await self.authService.loginWithEmailAndPassword(email: email, password: password) else { return }

      self.user = UserProfile(email: user.email ?? "",
                              name: user.displayName ?? "",
                              photoUrl: user.photoURL,
                              firebaseUser: user)

      self.loginState = .signedInWithEmail
    } catch {
      print(error.localizedDescription)
      throw AuthErrors.firebaseError
    }
  }

  func loginWithGoogle() async throws {
    do {
      guard let user = try await self.authService.loginWithGoogle() else { return }

      self.user = UserProfile(email: user.email ?? "",
                              name: user.displayName ?? "",
                              photoUrl: user.photoURL,
                              firebaseUser: user)

      self.loginState = .signedInWithGoogle
    } catch {
      print(error.localizedDescription)
      throw AuthErrors.firebaseError
    }
  }

  func logout() throws {
    do {
      try self.authService.logout()
      self.loginState = .signedOut
    } catch {
      print(error.localizedDescription)
      throw AuthErrors.firebaseError
    }
  }
}
