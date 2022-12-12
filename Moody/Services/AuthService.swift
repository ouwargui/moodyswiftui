//
//  AuthService.swift
//  Moody
//
//  Created by Guilherme Santos on 12/12/22.
//

import FirebaseAuth
import Foundation

class AuthService {
  func loginWithEmailAndPassword(email: String, password: String) async throws -> User? {
    do {
      let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
      let user = authResult.user

      return user
    } catch {
      throw error
    }
  }

  func logout() throws {
    do {
      try Auth.auth().signOut()
    } catch {
      throw error
    }
  }
}
