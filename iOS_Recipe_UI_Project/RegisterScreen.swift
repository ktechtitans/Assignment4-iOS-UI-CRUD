//
//  RegisterScreen.swift
//  iOS_Recipe_UI_Project
//
//  Created by Kanchan Kaur on 2024-12-06.
//


import SwiftUI

struct RegisterScreen: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var registrationMessage: String = ""
    @State private var registrationSuccess: Bool = false
    
    var onRegisterSuccess: (() -> Void)? // Closure to notify parent view

    var body: some View {
        NavigationView {
            VStack {
                Text("Create Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.bottom, 50)

                TextField("Username", text: $username)
                    .padding()
                    .border(Color.gray)

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
                        .cornerRadius(8)
                        .padding(.top, 50)
                }

                Text(registrationMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            .padding()
        }
    }

    func registerUser() {
        // Simulate API registration call
        APIService.register(username: username, email: email, password: password) { success, errorMessage in
            DispatchQueue.main.async {
                if success {
                    registrationMessage = "Registration successful!"
                    registrationSuccess = true
                    onRegisterSuccess?() // Notify parent view of successful registration
                } else {
                    registrationMessage = errorMessage ?? "An unknown error occurred."
                }
            }
        }
    }
}


struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
    }
}
