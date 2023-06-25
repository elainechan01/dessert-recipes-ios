//
//  SwiftUIView.swift
//  DessertRecipes
//
//  Created by Elaine Chan on 6/24/23.
//

import SwiftUI

struct DessertView: View {
    
    @ObservedObject var dessertViewModel: DessertViewModel
    
    var body: some View {
        Text("Testing")
        NavigationStack {
            List (self.dessertViewModel.meals, id: \.idMeal) { dessert in
                DessertRowView(dessert: dessert)
            }
        }
        .onAppear {
            self.dessertViewModel.getAllDesserts()
            print(self.dessertViewModel.meals)
        }
    }
}

struct DessertView_Previews: PreviewProvider {
    static var previews: some View {
        let dessertViewModel = DessertViewModel()
        DessertView(dessertViewModel: dessertViewModel)
    }
}
