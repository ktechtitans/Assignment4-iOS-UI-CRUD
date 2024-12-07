//
//  Recipe.swift
//  iOS_Recipe_UI_Project
//
//  Created by Kanchan Kaur on 2024-12-06.
//

import Foundation

struct Recipe: Identifiable, Codable {
    var id: String {
        return _id
    }
    
    let _id: String
    let recipeName: String
    let cuisine: String
    let averageRating: Double
}



