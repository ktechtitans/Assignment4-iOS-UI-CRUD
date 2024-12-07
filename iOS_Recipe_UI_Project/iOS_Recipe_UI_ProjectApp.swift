//
//  iOS_Recipe_UI_ProjectApp.swift
//  iOS_Recipe_UI_Project
//
//  Created by Kanchan Kaur on 2024-12-06.
//

import SwiftUI

@main
struct iOS_Recipe_UI_ProjectApp: App {
    @State private var isLoggedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                RecipeListScreen() 
            } else {
                RegisterScreen(isLoggedIn: $isLoggedIn)
            }
        }
    }
}



