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

@MainActor
class AuthStore: NSObject, ObservableObject, ASAuthorizationControllerDelegate {
  @Published var loginState: LoginState = .signedOut
  @Published var user: UserProfile?
  @Published var isAuthLoaded: Bool = false

  private var authListener: AuthStateDidChangeListenerHandle?
  private var onAppleAuthError: ((_ error: Error) -> Void)?

  func loginWithGoogle() async throws {
    let googleSignIn = GIDSignIn.sharedInstance
    var googleUser: GIDGoogleUser

    if googleSignIn.hasPreviousSignIn() {
      do {
        googleUser = try await googleSignIn.restorePreviousSignIn()
      } catch {
        self.signOutWithGoogle()
        throw error
      }
    } else {
      guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
      guard let rootViewController = windowScene.windows.first?.rootViewController else { return }

      do {
        let result = try await googleSignIn.signIn(withPresenting: rootViewController)
        googleUser = result.user
      } catch {
        throw error
      }
    }

    guard let idToken = googleUser.idToken else { return }
    let accessToken = googleUser.accessToken
    let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                   accessToken: accessToken.tokenString)

    do {
      try await self.authenticateWithFirebase(credential: credential)
    } catch {
      throw error
    }
  }

  func logout() {
    try? Auth.auth().signOut()
    self.signOutWithGoogle()
    self.loginState = .signedOut
  }

  private func signOutWithGoogle() {
    GIDSignIn.sharedInstance.signOut()
  }

  private func authenticateWithFirebase(credential: AuthCredential) async throws {
    do {
      try await Auth.auth().signIn(with: credential)
    } catch {
      throw error
    }
  }

  func startAuthStateListener() {
    self.authListener = Auth.auth().addStateDidChangeListener { _, user in
      guard let user = user else {
        self.isAuthLoaded = true
        return
      }

      let userProfile = UserProfile(email: user.email ?? "",
                                    name: user.displayName ?? "",
                                    photoUrl: user.photoURL,
                                    firebaseUser: user)
      self.user = userProfile
      self.loginState = .signedIn
      self.isAuthLoaded = true
    }
  }

  func removeAuthStateListener() {
    guard let authListener = self.authListener else { return }
    Auth.auth().removeStateDidChangeListener(authListener)
  }
}

// MARK: apple authentication

extension AuthStore {
  func loginWithApple(onError: @escaping (_ error: Error) -> Void) {
    self.onAppleAuthError = onError

    let nonce = AuthCryptoService.randomNonceString()
    let appleIdProvider = ASAuthorizationAppleIDProvider()
    let request = appleIdProvider.createRequest()
    request.requestedScopes = [.email, .fullName]
    request.nonce = AuthCryptoService.sha256(nonce)

    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.delegate = self
    authorizationController.performRequests()
  }

  nonisolated func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
      guard let appleIdToken = appleIdCredential.identityToken else {
        print("Unable to fetch identity token")
        return
      }

      guard let idTokenString = String(data: appleIdToken, encoding: .utf8) else {
        print("Unable to serialize token string from data: \(appleIdToken.debugDescription)")
        return
      }

      let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                idToken: idTokenString,
                                                rawNonce: AuthCryptoService.currentNonce)

      Task {
        do {
          try await self.authenticateWithFirebase(credential: credential)
        } catch {
          await self.onAppleAuthError!(error)
        }
      }
    }
  }

  nonisolated func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    Task {
      await self.onAppleAuthError!(error)
    }
  }
}

extension AuthStore {
  enum AuthErrors: Error {
    case badEmail
    case badPassword
    case firebaseError
  }

  enum LoginState {
    case signedIn
    case signedOut
  }
}
