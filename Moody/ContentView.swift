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
        if userStore.isLoggedIn {
          HomeView()
            .transition(.move(edge: .trailing))
        } else {
          LoginView()
            .transition(.move(edge: .leading))
        }
      }
      .animation(.default, value: userStore.isLoggedIn)
    }
    .environmentObject(userStore)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
