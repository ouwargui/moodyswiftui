//
//  AuthService.swift
//  Moody
//
//  Created by Guilherme Santos on 12/12/22.
//

import Firebase
import FirebaseAuth
import Foundation
import GoogleSignIn

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
      GIDSignIn.sharedInstance.signOut()
      try Auth.auth().signOut()
    } catch {
      throw error
    }
  }

  func loginWithGoogle() async throws -> User? {
    do {
      let googleSignIn = GIDSignIn.sharedInstance

      if googleSignIn.hasPreviousSignIn() {
        let user = try await googleSignIn.restorePreviousSignIn()
        let userAuthenticated = try await authenticateUser(with: user)
        return userAuthenticated
      }

      guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene else { return nil }
      guard let rootViewController = await windowScene.windows.first?.rootViewController else { return nil }

      let result = try await googleSignIn.signIn(withPresenting: rootViewController)
      let userAuthenticated = try await authenticateUser(with: result.user)
      return userAuthenticated
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }

  private func authenticateUser(with user: GIDGoogleUser?) async throws -> User? {
    do {
      guard let accessToken = user?.accessToken, let idToken = user?.idToken else { return nil }
      let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)

      let authResult = try await Auth.auth().signIn(with: credential)
      let user = authResult.user
      return user
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }
}
