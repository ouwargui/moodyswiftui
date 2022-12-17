//
//  MoodyApp.swift
//  Moody
//
//  Created by Guilherme Santos on 03/12/22.
//

import Firebase
import SwiftUI

@main
struct MoodyApp: App {
  @StateObject private var authStore = AuthStore()

  init() {
    FirebaseApp.configure()
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
        .onAppear {
          authStore.startAuthStateListener()
        }
        .onDisappear {
          
        }
        .environmentObject(authStore)
    }
  }
}
