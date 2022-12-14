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
  @EnvironmentObject var userStore: UserStore
  @ObservedObject var viewModel = LoginViewViewModel()

  var body: some View {
    ZStack(alignment: .top) {
      Color.black
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

          Spacer()

          ZStack {
            Divider()
              .overlay(Color.white)

            Text("Social Login")
              .foregroundColor(.white)
              .padding(.horizontal)
              .background(.black)
          }

          VStack {
            Button {
              Task {
                try await userStore.loginWithGoogle()
              }
            } label: {
              HStack {
                Image("google_logo")
                  .resizable()
                  .scaledToFit()
                  .frame(height: 20)
                
                Text("Sign in with Google")
                  .foregroundColor(.black)
                  .font(.custom("SF Pro Text", size: 24))
                  .fontWeight(.black)
              }
              .frame(maxWidth: .infinity, maxHeight: 28)
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 5)
                  .foregroundColor(.white)
              )
            }

            
            SignInWithAppleButton { request in
              request.requestedScopes = [.email, .fullName]
            } onCompletion: { result in
              switch result {
              case .success:
                print("success")
              case .failure(let error):
                print(error.localizedDescription)
              }
            }
            .signInWithAppleButtonStyle(.white)

          }
          .padding()
          .frame(width: 300)

          Button {
            print("tap")
          } label: {
            Text("Don't have an account?\nCreate a new account")
              .foregroundColor(.white)
          }
          .padding(.vertical)

          Spacer()
        }
        .padding(.horizontal)
      }
    }
    .ignoresSafeArea(.keyboard)
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      LoginView()
    }
  }
}
