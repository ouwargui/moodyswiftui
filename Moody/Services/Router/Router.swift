//
//  Router.swift
//  Moody
//
//  Created by Guilherme Santos on 18/02/23.
//

import SwiftUI

class Router: ObservableObject {
  @Published var path = NavigationPath()
  
  func reset() {
    path = NavigationPath()
  }
}
