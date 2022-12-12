//
//  UserProfile.swift
//  Moody
//
//  Created by Guilherme Santos on 12/12/22.
//

import FirebaseAuth
import Foundation

struct UserProfile: Identifiable {
  let id = UUID()
  let email: String
  let name: String
  let photoUrl: URL?
  let firebaseUser: User
}
