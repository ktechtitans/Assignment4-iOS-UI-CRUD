//
//  RegisterScreen.swift
//  iOS_Recipe_UI_Project
//
//  Created by Kanchan Kaur on 2024-12-06.
//

import SwiftUI

struct RegisterScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var registrationMessage: String = ""
    @State private var registrationSuccess: Bool = false // State to track registration success

    var body: some View {
        NavigationView {
            VStack {
                    
                Text("Create Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.bottom, 50)
                
                TextField("Email", text: $email)
                    .padding()
                    .border(Color.gray)

                SecureField("Password", text: $password)
                    .padding()
                    .border(Color.gray)

                Button(action: registerUser) {
                    Text("Register")
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(0)
                        .padding(.top, 50)
                }

                Text(registrationMessage)
                    .foregroundColor(.red)
                    .padding()

                // NavigationLink to go to LoginScreen after registration success
                NavigationLink(destination: LoginScreen(), isActive: $registrationSuccess) {
                    EmptyView() // EmptyView is used to perform navigation programmatically
                }

                // Already have an account? Login Button
                NavigationLink(destination: LoginScreen()) {
                    Text("Already have an account? Login")
                        .foregroundColor(.blue)
                        .padding(.top, 20)
                }
            }
            .padding()
        }
    }
    
    func registerUser() {
        APIService.register(email: email, password: password) { success, errorMessage in
            if success {
                registrationMessage = "Registration successful!"
                registrationSuccess = true // Trigger navigation after successful registration
            } else {
                registrationMessage = errorMessage ?? "An unknown error occurred."
            }
        }
    }
}

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
    }
}
