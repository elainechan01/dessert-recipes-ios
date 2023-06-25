//
//  SwiftUIView.swift
//  DessertRecipes
//
//  Created by Elaine Chan on 6/24/23.
//

import SwiftUI

struct DessertView: View {
    
    @StateObject private var dessertViewModel = DessertViewModel()
    
    var body: some View {
        Text("Desserts")
        NavigationStack {
            List (dessertViewModel.dessertList, id: \.idMeal) { dessert in
                NavigationLink {
                    DessertDetailView(dessert: dessert)
                } label: {
                    DessertRowView(dessert: dessert)
                }
            }
        }
        .onAppear {
            dessertViewModel.getAllDesserts()
        }
    }
}

struct DessertView_Previews: PreviewProvider {
    static var previews: some View {
        DessertView()
    }
}
