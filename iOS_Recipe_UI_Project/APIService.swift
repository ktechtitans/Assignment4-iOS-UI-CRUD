//
//  APIService.swift
//  iOS_Recipe_UI_Project
//
//  Created by Kanchan Kaur on 2024-12-06.
//

import Foundation

struct APIService {
    // Update baseURL to the correct API URL
    static let baseURL = "https://assignment-4-jwt.onrender.com" // Updated to your correct Render URL

    // Login method
    static func login(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        let url = URL(string: "\(baseURL)/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["username": username, "password": password]
        
        // Convert the body to JSON data
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        // Data task to handle login
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Error handling for network errors
            if let error = error {
                completion(false, error.localizedDescription)
                return
            }

            // Handle successful response
            guard let data = data else {
                completion(false, "No data received")
                return
            }
            
            // Try to decode JSON response to get the login result
            do {
                if let responseDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let message = responseDict["message"] as? String, message == "Login successful" {
                    completion(true, nil)
                } else {
                    completion(false, "Invalid username or password.")
                }
            } catch {
                completion(false, "Failed to parse response.")
            }
        }
        task.resume()
    }

    // Register method
    static func register(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        let url = URL(string: "\(baseURL)/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Send email and password in the request body
        let body = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        // Data task to handle registration
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Error handling for network errors
            if let error = error {
                completion(false, error.localizedDescription)
                return
            }

            // Handle successful response
            guard let data = data else {
                completion(false, "No data received")
                return
            }

            // Try to decode JSON response to get registration result
            do {
                if let responseDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let message = responseDict["message"] as? String, message == "User registered successfully" {
                    completion(true, nil)
                } else {
                    completion(false, "Registration failed. Try again.")
                }
            } catch {
                completion(false, "Failed to parse response.")
            }
        }
        task.resume()
    }
}
