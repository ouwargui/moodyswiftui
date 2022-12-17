//
//  Splashscreen.swift
//  Moody
//
//  Created by Guilherme Santos on 17/12/22.
//

import SwiftUI

struct Splashscreen: View {
  var body: some View {
    ZStack {
      Color.black

      Text("Moody")
        .foregroundColor(.white)
        .font(.system(size: 40, weight: .bold))
    }
    .ignoresSafeArea()
  }
}

struct Splashscreen_Previews: PreviewProvider {
  static var previews: some View {
    Splashscreen()
  }
}
