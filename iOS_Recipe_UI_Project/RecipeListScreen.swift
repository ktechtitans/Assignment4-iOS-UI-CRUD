//
//  RecipeListScreen.swift
//  iOS_Recipe_UI_Project
//
//  Created by Kanchan Kaur on 2024-12-06.
//

import SwiftUI

struct RecipeListScreen: View {
    var body: some View {
        NavigationView {
            List {
                // Example Recipe List Content
                Text("Recipe 1")
                Text("Recipe 2")
                Text("Recipe 3")
            }
            .navigationTitle("Recipes")
            .toolbar {
                // Add button to the toolbar in macOS using .primaryAction
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        // Action for adding a new recipe
                        print("Add Recipe Button Pressed")
                    }) {
                        Text("Add Recipe")
                    }
                }
            }
        }
    }
}

struct RecipeListScreen_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListScreen()
    }
}
