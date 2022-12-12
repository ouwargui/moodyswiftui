//
//  HomeView.swift
//  Moody
//
//  Created by Guilherme Santos on 07/12/22.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject var userStore: UserStore

  var body: some View {
    CustomButton(title: "SIGN OUT", isDisabled: false) {
      Task {
        try userStore.logout()
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
