//
//  Recipe.swift
//  iOS_Recipe_UI_Project
//
//  Created by Kanchan Kaur on 2024-12-06.
//

import Foundation

struct Recipe: Identifiable, Decodable {
    var id: String
    var recipeName: String
    var cuisine: String
    var averageRating: Double

    enum CodingKeys: String, CodingKey {
        case id
        case recipeName
        case cuisine
        case averageRating
    }
}



