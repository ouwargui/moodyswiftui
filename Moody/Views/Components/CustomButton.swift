//
//  CustomButton.swift
//  Moody
//
//  Created by Guilherme Santos on 10/12/22.
//

import SwiftUI

struct CustomButton: View {
  let title: String
  let isDisabled: Bool
  let isLoading: Bool
  let onPress: () -> Void

  var body: some View {
    Button {
      onPress()
    } label: {
      if !isLoading {
        Text(title.uppercased())
          .bold()
          .foregroundColor(isDisabled ? .white.opacity(0.5) : .white)
          .frame(maxWidth: .infinity, maxHeight: 70)
          .overlay(
            RoundedRectangle(cornerRadius: 50)
              .stroke(isDisabled ? .white.opacity(0.5) : .white, lineWidth: 2)
          )
      } else {
        ProgressView()
          .scaleEffect(1.2)
          .frame(maxWidth: .infinity, maxHeight: 70)
          .overlay(
            RoundedRectangle(cornerRadius: 50)
              .stroke(isDisabled ? .white.opacity(0.5) : .white, lineWidth: 2)
          )
      }
    }
    .disabled(isDisabled)
    .animation(.easeInOut(duration: 0.5), value: isDisabled)
  }
}

struct CustomButton_Previews: PreviewProvider {
  static var previews: some View {
    CustomButton(title: "sign in", isDisabled: true, isLoading: true) {
      print("tapped")
    }
  }
}
