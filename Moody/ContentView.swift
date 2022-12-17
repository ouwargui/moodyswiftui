//
//  ContentView.swift
//  Moody
//
//  Created by Guilherme Santos on 07/12/22.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var authStore: AuthStore

  var body: some View {
    NavigationStack {
      ZStack {
        if authStore.loginState == .signedOut {
          LoginView()
            .transition(.move(edge: .leading))
        } else {
          HomeView()
            .transition(.move(edge: .trailing))
        }
      }
      .animation(.default, value: authStore.loginState)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
