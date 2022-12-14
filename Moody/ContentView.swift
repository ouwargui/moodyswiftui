//
//  ContentView.swift
//  Moody
//
//  Created by Guilherme Santos on 07/12/22.
//

import SwiftUI

struct ContentView: View {
  @StateObject var userStore = UserStore()

  var body: some View {
    NavigationStack {
      ZStack {
        if userStore.loginState == .signedOut {
          LoginView()
            .transition(.move(edge: .leading))
        } else {
          HomeView()
            .transition(.move(edge: .trailing))
        }
      }
      .animation(.default, value: userStore.loginState)
    }
    .environmentObject(userStore)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
