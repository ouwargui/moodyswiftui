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
    NavigationView {
      if userStore.isLoggedIn {
        HomeView()
      } else {
        LoginView()
      }
    }
    .environmentObject(userStore)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
