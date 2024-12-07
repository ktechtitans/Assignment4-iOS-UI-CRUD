//
//  LoginScreen.swift
//  iOS_Recipe_UI_Project
//
//  Created by Kanchan Kaur on 2024-12-06.
//

import SwiftUI

struct LoginScreen: View {
    @Binding var isLoggedIn: Bool 
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loginFailed: Bool = false
    @State private var loginMessage: String = ""

    var body: some View {
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
        }
        .padding()
    }

    func loginUser() {
        
        APIService.login(username: username, password: password) { success, errorMessage in
            if success {
              
                loginMessage = "Login successful!"
                loginFailed = false
                isLoggedIn = true
            } else {
               
                loginMessage = errorMessage ?? "Invalid username or password."
                loginFailed = true
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(isLoggedIn: .constant(false))
    }
}

