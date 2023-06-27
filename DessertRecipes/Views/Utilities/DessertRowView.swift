//
//  MealRowView.swift
//  DessertRecipes
//
//  Created by Elaine Chan on 6/24/23.
//

import SwiftUI

// SwiftUI view to display dessert meal in a row
struct DessertRowView: View {
    
    // Data passed from parent view
    var dessert: Dessert
    
    var body: some View {
        HStack {
            // Display meal thumbnail or placeholder loader if not ready
            AsyncImage(url: URL(string: dessert.strMealThumb), content: { image in
            image.resizable()
            }, placeholder: {
                ProgressView()
            })
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            // Display meal name
            Text(dessert.strMeal)
        }
    }
}

struct DessertRowView_Previews: PreviewProvider {
    static var previews: some View {
        let testDessert = Dessert(
            strMeal: "Apam balik",
            strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
            idMeal: "53049"
        )
        DessertRowView(dessert: testDessert)
    }
}
