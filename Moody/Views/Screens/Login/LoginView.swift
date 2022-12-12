//
//  LoginView.swift
//  Moody
//
//  Created by Guilherme Santos on 07/12/22.
//

import FirebaseAuth
import SwiftUI

struct LoginView: View {
  @EnvironmentObject var userStore: UserStore
  @ObservedObject var viewModel = LoginViewViewModel()

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
            CustomInput(text: $viewModel.email, placeholder: "Email", isPassword: false)
            CustomInput(text: $viewModel.password, placeholder: "Password", isPassword: true)
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

          CustomButton(title: "SIGN IN", isDisabled: viewModel.isButtonDisabled, isLoading: viewModel.isButtonLoading) {
            Task {
              await viewModel.login(userStore: userStore)
            }
          }
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
