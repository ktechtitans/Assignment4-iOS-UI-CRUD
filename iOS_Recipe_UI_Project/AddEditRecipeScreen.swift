//
//  AddEditRecipeScreen.swift
//  iOS_Recipe_UI_Project
//
//  Created by Kanchan Kaur on 2024-12-06.
//

import SwiftUI

struct AddEditRecipeScreen: View {
    @Binding var recipe: Recipe?
    @State private var title: String
    @State private var cuisine: String
    @State private var rating: Double
    var onSave: (Recipe) -> Void

    // Initializer
    init(recipe: Binding<Recipe?>, onSave: @escaping (Recipe) -> Void) {
        _recipe = recipe
        _title = State(initialValue: recipe.wrappedValue?.recipeName ?? "")
        _cuisine = State(initialValue: recipe.wrappedValue?.cuisine ?? "")
        _rating = State(initialValue: recipe.wrappedValue?.averageRating ?? 0.0)
        self.onSave = onSave
    }

    var body: some View {
        Form {
            Section(header: Text("Recipe Details")) {
                TextField("Recipe Name", text: $title)
                TextField("Cuisine", text: $cuisine)
                HStack {
                    Text("Rating: \(String(format: "%.1f", rating))")
                    Slider(value: $rating, in: 0...5, step: 0.1)
                }
            }

            Button(action: {
                let updatedRecipe = Recipe(
                    id: recipe?.id ?? UUID().uuidString,
                    recipeName: title,
                    cuisine: cuisine,
                    averageRating: rating
                )
                onSave(updatedRecipe)
            }) {
                Text(recipe == nil ? "Add Recipe" : "Save Changes")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .navigationTitle(recipe == nil ? "Add Recipe" : "Edit Recipe")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddEditRecipeScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddEditRecipeScreen(
                recipe: .constant(nil),
                onSave: { _ in
                    print("Recipe saved in preview.") 
                }
            )
        }
    }
}

