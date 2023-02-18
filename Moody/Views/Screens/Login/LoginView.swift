//
//  LoginView.swift
//  Moody
//
//  Created by Guilherme Santos on 07/12/22.
//

import AuthenticationServices
import FirebaseAuth
import GoogleSignInSwift
import SwiftUI

struct LoginView: View {
  @EnvironmentObject var authStore: AuthStore
  @ObservedObject var viewModel = LoginViewViewModel()

  var body: some View {
    ZStack(alignment: .top) {
      Color.black
        .ignoresSafeArea()

      VStack {
        logo

        VStack {
          inputs

          forgotPassword

          loginButton

          Spacer()

          divider

          socialLogin

          createAccount

          Spacer()
        }
        .padding(.horizontal)
      }
    }
    .ignoresSafeArea(.keyboard)
    .alert(viewModel.alertTitle, isPresented: $viewModel.isAlertShowing) {
      Button(role: .cancel) {
        viewModel.dismissAlert()
      } label: {
        Text("Ok")
      }

    } message: {
      Text(viewModel.alertMessage)
    }
  }
}

extension LoginView {
  private var logo: some View {
    Text("Moody")
      .font(.largeTitle)
      .fontWeight(.bold)
      .foregroundColor(.white)
      .padding()
      .frame(height: 200)
  }

  private var inputs: some View {
    VStack(spacing: 25) {
      CustomInput(text: $viewModel.email, placeholder: "Email", isPassword: false)
      CustomInput(text: $viewModel.password, placeholder: "Password", isPassword: true)
    }
  }

  private var forgotPassword: some View {
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
  }

  private var loginButton: some View {
    CustomButton(title: "SIGN IN", isDisabled: viewModel.isButtonDisabled, isLoading: viewModel.isButtonLoading) {
      Task {
        await viewModel.loginWithEmailAndPassword(authStore: authStore)
      }
    }
    .padding(.vertical)
  }

  private var divider: some View {
    ZStack {
      Divider()
        .overlay(Color.white)

      Text("Social Login")
        .foregroundColor(.white)
        .padding(.horizontal)
        .background(.black)
    }
  }

  private var socialLogin: some View {
    HStack {
      Spacer()
      googleLogin
      Spacer()
      appleLogin
      Spacer()
    }
    .padding()
  }

  private var googleLogin: some View {
    Button {
      Task {
        await viewModel.loginWithGoogle(authStore: self.authStore)
      }
    } label: {
      RoundedRectangle(cornerRadius: 10)
        .frame(width: 80, height: 80)
        .foregroundColor(.white)
        .overlay {
          Image("google_logo")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
        }
    }
  }

  private var appleLogin: some View {
    Button {
      Task {
        await viewModel.loginWithApple(authStore: self.authStore)
      }
    } label: {
      RoundedRectangle(cornerRadius: 10)
        .frame(width: 80, height: 80)
        .foregroundColor(.white)
        .overlay {
          Image(systemName: "apple.logo")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .foregroundColor(.black)
        }
    }
  }

  private var createAccount: some View {
    NavigationLink(value: NotAuthenticatedRoutes.SignupRoute) {
      Text("Don't have an account?\nCreate a new account")
        .foregroundColor(.white)
    }
    .padding(.vertical)
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      LoginView()
    }
  }
}
