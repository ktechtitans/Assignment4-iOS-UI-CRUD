//
//  RecipeListScreen.swift
//  iOS_Recipe_UI_Project
//
//  Created by Kanchan Kaur on 2024-12-06.
//

import SwiftUI

struct RecipeListScreen: View {
    @State private var recipes: [Recipe] = []
    @State private var isAddEditScreenActive = false
    @State private var selectedRecipe: Recipe?
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                List {
                    ForEach(recipes) { recipe in
                        CustomRecipeCell(recipe: recipe, onEdit: {
                            selectedRecipe = recipe
                            isAddEditScreenActive = true
                        }, onDelete: {
                            deleteRecipe(recipe)
                        })
                    }
                }
                .navigationTitle("Recipes")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: logout) {
                            Text("Logout")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            selectedRecipe = nil
                            isAddEditScreenActive = true
                        }) {
                            Text("Add Recipe")
                        }
                    }
                }
                .onAppear {
                    fetchRecipes()
                }
                .background(
                    NavigationLink(destination: AddEditRecipeScreen(recipe: $selectedRecipe, onSave: handleSave), isActive: $isAddEditScreenActive) {
                        EmptyView()
                    }
                )
            }
        }
    }
    
    // Fetch Recipes
    private func fetchRecipes() {
        APIService.fetchRecipes { fetchedRecipes, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error
                } else if let fetchedRecipes = fetchedRecipes {
                    self.recipes = fetchedRecipes
                }
            }
        }
    }
    
    // Delete Recipe
    private func deleteRecipe(_ recipe: Recipe) {
        recipes.removeAll { $0.id == recipe.id }
        // Call delete API if needed
    }
    
    // Logout
    private func logout() {
        // Clear session or token
        // Navigate to login screen
        print("Logout action triggered")
    }
    
    // Handle Save
    private func handleSave(recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index] = recipe // Update existing recipe
        } else {
            recipes.append(recipe) // Add new recipe
        }
        isAddEditScreenActive = false
    }
}

struct CustomRecipeCell: View {
    var recipe: Recipe
    var onEdit: () -> Void
    var onDelete: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(recipe.recipeName)
                    .font(.headline)
                Text("Cuisine: \(recipe.cuisine)")
                    .font(.subheadline)
                Text("Rating: \(String(format: "%.1f", recipe.averageRating)) ⭐️")
                    .font(.subheadline)
            }
            Spacer()
            Button(action: onEdit) {
                Image(systemName: "pencil")
                    .foregroundColor(.blue)
            }
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
    }
}

struct RecipeListScreen_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListScreen()
    }
}

