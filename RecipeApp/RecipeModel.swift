//
//  RecipeModel.swift
//  RecipeApp
//
//  Created by Aadhil Abdulla on 05/11/25.
//

import Foundation

struct RecipeModel: Codable, Identifiable {
    var id: Int
    var title: String
    var image: String
}


struct LocalRecipeModel: Codable, Identifiable {
    var id: Int
    var title: String
    var image: String
    var isFav: Bool = false
}
