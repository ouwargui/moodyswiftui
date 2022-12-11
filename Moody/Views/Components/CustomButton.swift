//
//  CustomButton.swift
//  Moody
//
//  Created by Guilherme Santos on 10/12/22.
//

import SwiftUI

struct CustomButton: View {
  let title: String

  var body: some View {
    Button {} label: {
      Text(title.uppercased())
        .foregroundColor(.white)
    }
    .frame(maxWidth: .infinity, maxHeight: 70)
    .overlay(
      RoundedRectangle(cornerRadius: 50)
        .stroke(.white, lineWidth: 2)
    )
  }
}

struct CustomButton_Previews: PreviewProvider {
  static var previews: some View {
    CustomButton(title: "sign in")
  }
}
