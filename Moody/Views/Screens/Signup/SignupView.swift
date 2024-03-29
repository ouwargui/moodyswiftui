//
//  SignupView.swift
//  Moody
//
//  Created by Guilherme Santos on 19/12/22.
//

import SwiftUI

struct SignupView: View {
  @EnvironmentObject var authStore: AuthStore
  @ObservedObject var viewModel = SignupViewViewModel()

  var body: some View {
    ZStack(alignment: .top) {
      Color.black.ignoresSafeArea()

      VStack {
        Text("Let's create your account")
          .font(.title2)
          .fontWeight(.bold)
          .foregroundColor(.white)
          .padding()
          .padding(.vertical)

        VStack(spacing: 25) {
          CustomInput(text: $viewModel.email, placeholder: "Email", isPassword: false)
          CustomInput(text: $viewModel.password, placeholder: "Password", isPassword: true)
          CustomInput(text: $viewModel.passwordConfirmation, placeholder: "Confirm your password", isPassword: true)
        }

        CustomButton(title: "SIGN UP", isDisabled: viewModel.isButtonDisabled, isLoading: viewModel.isButtonLoading) {
          Task {
            await viewModel.signup(authStore: self.authStore)
          }
        }
        .padding(.top, 30)
      }
      .padding(.horizontal)
    }
    .alert(viewModel.alertTitle, isPresented: $viewModel.isAlertShowing) {
      Button {
        viewModel.dismissAlert()
      } label: {
        Text("Ok")
      }
    } message: {
      Text(viewModel.alertMessage)
    }
  }
}

struct SignupView_Previews: PreviewProvider {
  static var previews: some View {
    SignupView()
  }
}
