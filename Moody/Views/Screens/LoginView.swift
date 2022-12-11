//
//  LoginView.swift
//  Moody
//
//  Created by Guilherme Santos on 07/12/22.
//

import SwiftUI

struct LoginView: View {
  @State private var email = ""
  @State private var password = ""

  var body: some View {
    ZStack(alignment: .top) {
      Color.backgroundPrimary
        .ignoresSafeArea()

      VStack {
        Text("Moody")
          .font(.largeTitle)
          .fontWeight(.bold)
          .foregroundColor(.white)
          .padding()
          .frame(height: 200)

        VStack {
          VStack(spacing: 25) {
            CustomInput(text: $email, placeholder: "Email", isPassword: false)
            CustomInput(text: $password, placeholder: "Password", isPassword: true)
          }

          HStack {
            Spacer()

            Button {
              print("I forgot my password :(")
            } label: {
              Text("Forgot your password?")
                .padding(.vertical)
                .foregroundColor(.white)
            }
          }
          
          CustomButton(title: "SIGN IN")
            .padding(.vertical)
        }
        .padding(.horizontal)
      }
    }
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      LoginView()
    }
  }
}
