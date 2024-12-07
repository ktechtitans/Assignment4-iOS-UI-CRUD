//
//  AddEditRecipeScreen.swift
//  iOS_Recipe_UI_Project
//
//  Created by Kanchan Kaur on 2024-12-06.
//

import SwiftUI

struct AddEditRecipeView: View {
    @State private var title: String = ""
    @State private var studio: String = ""
    @State private var rating: String = ""
    @State private var isEditMode = false
    @State private var recipe: Recipe?

    var body: some View {
        Form {
            TextField("Recipe Title", text: $title)
                .padding()
                .border(Color.gray)

            TextField("Studio", text: $studio)
                .padding()
                .border(Color.gray)

            // Ensure that keyboardType is only applied to the correct TextField
            TextField("Rating", text: $rating)
                .padding()
                .border(Color.gray)
               

            Button(action: saveRecipe) {
                Text(isEditMode ? "Save Changes" : "Add Recipe")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Button(action: {
                // Dismiss and go back to the Recipe List Screen
            }) {
                Text("Cancel")
                    .foregroundColor(.red)
            }
        }
       
        .onAppear {
            if let recipe = recipe {
                isEditMode = true
                title = recipe.title
                studio = recipe.studio
                rating = "\(recipe.rating)"
            }
        }
    }

    func saveRecipe() {
        // Handle Add/Edit logic based on isEditMode
        // If editing, update the recipe, else create a new recipe
    }
}

struct AddEditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddEditRecipeView()
    }
}
