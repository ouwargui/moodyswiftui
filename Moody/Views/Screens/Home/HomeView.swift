//
//  HomeView.swift
//  Moody
//
//  Created by Guilherme Santos on 07/12/22.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject var userStore: UserStore
  @State private var isSheetPresented = false
  @State private var sheetContent = "friends"

  var body: some View {
    ZStack(alignment: .top) {
      Color.black
        .ignoresSafeArea()

      Header(sheetContent: $sheetContent,
             isSheetPresented: $isSheetPresented,
             profileImage: userStore.user?.photoUrl)
    }
    .sheet(isPresented: $isSheetPresented) {
      ZStack {
        Color.backgroundPrimary
          .ignoresSafeArea()

        Text(sheetContent)
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
      .environmentObject(UserStore())
  }
}
