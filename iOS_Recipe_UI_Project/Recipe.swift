//
//  Recipe.swift
//  iOS_Recipe_UI_Project
//
//  Created by Kanchan Kaur on 2024-12-06.
//

import Foundation

struct Recipe: Identifiable {
    var id: UUID = UUID()  // Unique identifier for each recipe
    var title: String      // Title of the recipe
    var studio: String     // Studio or creator of the recipe
    var rating: Int        // Rating of the recipe (can be an integer, e.g., 1-5)
}
