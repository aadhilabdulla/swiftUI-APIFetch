//
//  ViewModel.swift
//  RecipeApp
//
//  Created by Aadhil Abdulla on 05/11/25.
//

import Foundation
import Combine

struct Response: Decodable {
    var results: [RecipeModel]
    var offset: Int
    var number: Int
}

class ViewModel: ObservableObject {
    @Published var recipes: [LocalRecipeModel] = []
    @Published var isLoading = false
    
    func fetchData() async {
        isLoading = true
        let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch")
        
        var request = URLRequest(url : url!)
        request.httpMethod = "GET"
        request.setValue("140822fbb1254b078b0503c3e13807f8", forHTTPHeaderField: "x-api-key")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode(Response.self, from: data)
            
            await MainActor.run {
                isLoading = false
                recipes = decoded.results.map { recipe in
                    LocalRecipeModel(id: recipe.id, title: recipe.title, image: recipe.image, isFav: false)
                }
            }
        } catch {
            print("Error fetching API \(error)")
        }
        
    }
}
