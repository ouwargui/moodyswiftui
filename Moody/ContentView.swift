//
//  ContentView.swift
//  Moody
//
//  Created by Guilherme Santos on 07/12/22.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var authStore: AuthStore
  @EnvironmentObject var router: Router

  var body: some View {
    NavigationStack(path: $router.path) {
      ZStack {
        if !authStore.isAuthLoaded {
          Splashscreen()
        } else {
          if authStore.loginState == .signedOut {
            LoginView()
              .transition(.move(edge: .leading))
          } else {
            HomeView()
              .transition(.move(edge: .trailing))
          }
        }
      }
      .animation(.default, value: authStore.loginState)
      .navigationDestination(for: NotAuthenticatedRoutes.self) { $0 }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(AuthStore())
  }
}
