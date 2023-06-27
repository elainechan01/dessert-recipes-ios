//
//  SwiftUIView.swift
//  DessertRecipes
//
//  Created by Elaine Chan on 6/24/23.
//

import SwiftUI

// SwiftUI view to display list of dessert meals
struct DessertView: View {
    
    // Reference DessertViewModel
    @StateObject private var dessertViewModel = DessertViewModel()
    
    var body: some View {
        // Display title
        Text("Desserts")
        NavigationStack {
            // Display rows of dessert meals with the ability to navigate to dessertDetailView
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
