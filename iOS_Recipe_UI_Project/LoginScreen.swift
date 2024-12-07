//
//  LoginScreen.swift
//  iOS_Recipe_UI_Project
//
//  Created by Kanchan Kaur on 2024-12-06.
//

import SwiftUI

struct LoginScreen: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loginFailed: Bool = false
    @State private var loginMessage: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("Welcome Back!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.bottom, 50)
                
                TextField("Username", text: $username)
                    .padding()
                    .border(Color.gray)
                
                SecureField("Password", text: $password)
                    .padding()
                    .border(Color.gray)
                
                Button(action: loginUser) {
                    Text("Login")
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(0)
                        .padding(.top, 50)
                }
                
                if loginFailed {
                    Text(loginMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                // Navigation link to RegisterScreen
                NavigationLink(destination: RegisterScreen()) {
                    Text("Don't have an account? Register")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .padding()
            .navigationBarBackButtonHidden(true) // Hide back button here
        }
    }

    func loginUser() {
        // Call the login API to validate credentials
        APIService.login(username: username, password: password) { success, errorMessage in
            if success {
                // On successful login, navigate to the next screen or show a success message
                loginMessage = "Login successful!"
                loginFailed = false
                // Example: Navigate to HomePage or main screen (change this as needed)
                // For now, you can add any action here to perform post-login
            } else {
                // If login failed, display an error message
                loginMessage = errorMessage ?? "Invalid username or password."
                loginFailed = true
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
