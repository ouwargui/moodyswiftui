//
//  AuthService.swift
//  Moody
//
//  Created by Guilherme Santos on 12/12/22.
//

import AuthenticationServices
import Firebase
import FirebaseAuth
import Foundation
import GoogleSignIn

enum AuthErrors: Error {
  case badEmail
  case badPassword
  case firebaseError
}

@MainActor
class AuthStore: ObservableObject {
  enum LoginState {
    case signedInWithGoogle
    case signedInWithApple
    case signedInWithEmail
    case signedOut
  }

  private var authListener: AuthStateDidChangeListenerHandle?

  @Published var loginState: LoginState = .signedOut
  @Published var user: UserProfile?

  func startAuthStateListener() {
    self.authListener = Auth.auth().addStateDidChangeListener { _, user in
      guard let user = user else { return }

      let userProfile = UserProfile(email: user.email ?? "",
                                    name: user.displayName ?? "",
                                    photoUrl: user.photoURL,
                                    firebaseUser: user)
      self.user = userProfile
    }
  }

  func removeAuthStateListener() {
    guard let authListener = self.authListener else { return }
    Auth.auth().removeStateDidChangeListener(authListener)
  }
}
