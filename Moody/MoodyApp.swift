//
//  MoodyApp.swift
//  Moody
//
//  Created by Guilherme Santos on 03/12/22.
//

import FirebaseCore
import SwiftUI

@main
struct MoodyApp: App {
  init() {
    FirebaseApp.configure()
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
