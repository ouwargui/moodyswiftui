//
//  CustomInput.swift
//  Moody
//
//  Created by Guilherme Santos on 08/12/22.
//

import SwiftUI

struct CustomInput: View {
  @Binding var text: String
  let placeholder: String
  let isPassword: Bool

  @FocusState private var isFocusedState: Bool
  @State private var isFocused = false
  @State private var isShowingPassword = false

  var body: some View {
    ZStack(alignment: .leading) {
      if isPassword && !isShowingPassword {
        SecureField("", text: $text)
          .textInputAutocapitalization(.never)
          .textContentType(.password)
          .foregroundColor(.white)
          .padding()
          .focused($isFocusedState)
          .frame(height: 60)
          .overlay(
            RoundedRectangle(cornerRadius: 10)
              .stroke(isFocused ? .white : .white.opacity(0.5), lineWidth: 2)
          )
          .onChange(of: isFocusedState) { newFocusValue in
            withAnimation(.easeInOut(duration: 0.05)) {
              isFocused = newFocusValue || !text.isEmpty
            }
          }
      } else {
        TextField("", text: $text)
          .textInputAutocapitalization(.never)
          .textContentType(.emailAddress)
          .foregroundColor(.white)
          .padding()
          .focused($isFocusedState)
          .frame(height: 60)
          .overlay(
            RoundedRectangle(cornerRadius: 10)
              .stroke(isFocused ? .white : .white.opacity(0.5), lineWidth: 2)
          )
          .onChange(of: isFocusedState) { newFocusValue in
            withAnimation(.easeInOut(duration: 0.05)) {
              isFocused = newFocusValue || !text.isEmpty
            }
          }
      }

      HStack {
        Text(placeholder)
          .foregroundColor(isFocused ? .white : .white.opacity(0.5))
          .padding(5)
          .background(Color.black)
          .padding(.horizontal)
          .allowsHitTesting(false)
          .offset(y: isFocused ? -30 : 0)

        if isPassword {
          Spacer()
          
          Button {
            isShowingPassword.toggle()
          } label: {
            Image(systemName: isShowingPassword ? "eye.slash.fill" : "eye.fill")
              .font(.title2)
              .foregroundColor(isFocused ? .white : .white.opacity(0.5))
              .background(Color.black)
              .padding(.horizontal)
          }
        }
      }
    }
  }
}

struct CustomInput_Previews: PreviewProvider {
  @State static var text = ""

  static var previews: some View {
    CustomInput(text: $text, placeholder: "Email", isPassword: true)
  }
}
