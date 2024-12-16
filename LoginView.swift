//
//  LoginView.swift
//  nunu
//
//  Created by Riley Mitchell on 10/28/24.
//

import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool // Binding to track login status
    @State private var username: String = "" // State for username
    @State private var password: String = "" // State for password
    @State private var errorMessage: String? = nil // Error message for invalid credentials

    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .padding()

            // Username input field
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)

            // Password input field
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Error message
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            // Login button
            Button(action: {
                // Check if the username and password match
                if username == "USER" && password == "PASSWORD" {
                    self.isLoggedIn = true // Set isLoggedIn to true on success
                    self.errorMessage = nil // Clear any error message
                } else {
                    self.isLoggedIn = false
                    self.errorMessage = "Invalid credentials. Please try again." // Display error
                }
            }) {
                Text("Login")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(false)) // Preview with binding
    }
}


