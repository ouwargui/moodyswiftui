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
  init() {
    setupAuthentication()
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

extension MoodyApp {
  private func setupAuthentication() {
    FirebaseApp.configure()
  }
}
