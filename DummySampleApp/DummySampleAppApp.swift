//
//  DummySampleAppApp.swift
//  DummySampleApp
//
//  Created by Singh, Harshdeep on 2024-02-07.
//

import Amplify
import AWSCognitoAuthPlugin
import SwiftUI

@main
struct DummySampleAppApp: App {

    init() {
        initializeAmplify()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    private func initializeAmplify() {
        do {
            let userPoolId = "<>"
            let region = "<>"
            let clientId = "<>"
            Amplify.Logging.logLevel = .verbose
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            let configuration = AmplifyConfiguration(
                auth: AuthCategoryConfiguration(
                    plugins: [
                        "awsCognitoAuthPlugin": [
                            "IdentityManager": [
                                "Default": []
                            ],
                            "CognitoUserPool": [
                                "Default": [
                                    "PoolId": .string(userPoolId),
                                    "Region": .string(region),
                                    "AppClientId": .string(clientId)
                                ]
                            ]
                        ]
                    ]
                )
            )
            try Amplify.configure(configuration)
        } catch {
            assert(false, "Error initializing Amplify: \(error)")
        }
    }
}
