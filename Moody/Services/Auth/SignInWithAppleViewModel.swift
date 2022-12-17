//
//  SignInWithAppleViewModel.swift
//  Moody
//
//  Created by Guilherme Santos on 15/12/22.
//

import AuthenticationServices
import FirebaseAuth
import Foundation

class SignInWithAppleViewModel: NSObject, ASAuthorizationControllerDelegate {
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
      guard let appleIdToken = appleIdCredential.identityToken else {
        print("Unable to fetch identity token")
        return
      }

      guard let idTokenString = String(data: appleIdToken, encoding: .utf8) else {
        print("Unable to serialize token string from data: \(appleIdToken.debugDescription)")
        return
      }
      
      print(idTokenString)
    }
  }

  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    print("\n -- ASAuthorizationControllerDelegate -\(#function) -- \n")
    print(error)
  }
}
