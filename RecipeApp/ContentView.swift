//
//  ContentView.swift
//  RecipeApp
//
//  Created by Aadhil Abdulla on 05/11/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel = ViewModel()
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house"){
                RecipeHome(viewModel: viewModel)
            }
            Tab("Favourites", systemImage: "heart"){
                RecipeFavourites(viewModel: viewModel)
            }
            
        }
        .tint(.indigo)
    }
}

#Preview {
    ContentView()
}



struct RecipeHome: View {
    @State var search: String = ""
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button("Get All recipes") {
                        Task {
                            await viewModel.fetchData()
                        }
                    }
                }
                .padding()
                
                if viewModel.isLoading {
                    ProgressView()
                }
                else {
                    ScrollView {
                        ForEach($viewModel.recipes, id: \.id) { recipe in
                            VStack {
                                Text(recipe.wrappedValue.title)
                                    .padding()
                                Toggle("Favorite", isOn: recipe.isFav)
                                    .padding()
                                AsyncImage(url: URL(string: recipe.wrappedValue.image))
                                    .padding()
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.indigo.opacity(0.3), lineWidth: 4)
                            )
                            .padding()
                        }
                    }
                }
            }
        }
      
    }
}


struct RecipeFavourites: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            ScrollView {
                ForEach($viewModel.recipes, id: \.id) { recipe in
                    if (recipe.wrappedValue.isFav) {
                        VStack {
                            Text(recipe.wrappedValue.title)
                                .padding()
                            Toggle("Favorite", isOn: recipe.isFav)
                            AsyncImage(url: URL(string: recipe.wrappedValue.image))
                                .padding()
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.indigo.opacity(0.3), lineWidth: 4)
                        )
                        .padding()
                    }
                    
                }
            }
        }
    }
}
