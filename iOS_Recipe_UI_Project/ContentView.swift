//
//  ContentView.swift
//  iOS_Recipe_UI_Project
//
//  Created by Kanchan Kaur on 2024-12-06.
//

import SwiftUI

struct RecipeApp: App {
    @State private var isLoggedIn: Bool = false

    var body: some Scene {
        WindowGroup {
            RegisterScreen(isLoggedIn: $isLoggedIn) 
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    @State static var isLoggedIn: Bool = false
    static var previews: some View {
        RegisterScreen(isLoggedIn: $isLoggedIn)
    }
}



