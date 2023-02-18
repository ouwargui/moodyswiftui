//
//  Routes.swift
//  Moody
//
//  Created by Guilherme Santos on 18/02/23.
//

import SwiftUI

enum AuthenticatedRoutes {}

enum NotAuthenticatedRoutes: View {
  case SignupRoute

  var body: some View {
    switch self {
    case .SignupRoute:
      SignupView()
    }
  }
}
