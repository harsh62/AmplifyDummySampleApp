//
//  ContentView.swift
//  DummySampleApp
//
//  Created by Singh, Harshdeep on 2024-02-07.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin

struct ContentView: View {

    let username = "<>"

    let password: String? = nil
    let authFlowType: AuthFlowType = .customWithoutSRP

    @State var confirmationCode: String = ""

    var body: some View {
        VStack {
            Button("Sign In") {
                Task {
                    do {
                        let result = try await Amplify.Auth.signIn(
                            username: username,
                            password: password,
                            options: .init(pluginOptions: AWSAuthSignInOptions(authFlowType: authFlowType)))
                        print("sign in call complete with result \(result)")
                    }
                    catch {
                        print("Signed in error \(error)")
                    }
                }
            }
            HStack {
                TextField("ConfirmationCode", text: $confirmationCode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    Task {
                        Task {
                            do {
                                let result = try await Amplify.Auth.confirmSignIn(
                                    challengeResponse: confirmationCode)
                                print("confirm sign in call complete with result \(result)")
                            }
                            catch {
                                print("confirm sign in error \(error)")
                            }
                        }
                    }
                }) {
                    Text("Confirm Sign In")
                }
            }
            Button("Fetch Auth Session") {
                Task {
                    do {
                        let result = try await Amplify.Auth.fetchAuthSession(options: .forceRefresh())
                    }
                    catch {
                        print("Fetch Auth Session error: \(error)")
                    }
                }
            }
            Button("Sign Out") {
                Task {
                    let result = await Amplify.Auth.signOut()
                    print("Signed out with \(result)")
                }
            }
        }
        .padding()
    }
}
