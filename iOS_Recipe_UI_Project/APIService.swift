//
//  APIService.swift
//  iOS_Recipe_UI_Project
//
//  Created by Kanchan Kaur on 2024-12-06.
//



import Foundation

struct APIService {
    static let baseURL = "https://assignment-4-jwt.onrender.com"

    // User Registration
    static func register(username: String, email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        guard let url = URL(string: "\(baseURL)/api/user/register") else {
            completion(false, "Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Request body with username, email, and password
        let body: [String: Any] = ["username": username, "email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, error.localizedDescription)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                completion(false, "Invalid response from server")
                return
            }

            // Return success if no issues
            completion(true, nil)
        }
        task.resume()
    }

    // User Login
    static func login(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        guard let url = URL(string: "\(baseURL)/api/user/login") else {
            completion(false, "Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Request body with username and password
        let body: [String: Any] = ["username": username, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, error.localizedDescription)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(false, "Invalid username or password.")
                return
            }

            
            completion(true, nil)
        }
        task.resume()
    }

    // Fetch Recipes
    static func fetchRecipes(token: String, completion: @escaping ([Recipe]?, String?) -> Void) {
        guard let url = URL(string: "\(baseURL)/api/recipe") else {
            completion(nil, "Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error.localizedDescription)
                return
            }

            guard let data = data else {
                completion(nil, "No data received")
                return
            }

            do {
                
                let recipes = try JSONDecoder().decode([Recipe].self, from: data)
                completion(recipes, nil)
            } catch {
                completion(nil, "Failed to parse recipes")
            }
        }
        task.resume()
    }

    // Delete Recipe
    static func deleteRecipe(id: String, token: String, completion: @escaping (Bool, String?) -> Void) {
        guard let url = URL(string: "\(baseURL)/api/recipe/\(id)") else {
            completion(false, "Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, error.localizedDescription)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(false, "Failed to delete recipe.")
                return
            }

            
            completion(true, nil)
        }
        task.resume()
    }
}
