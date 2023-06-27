//
//  DessertDetailView.swift
//  DessertRecipes
//
//  Created by Elaine Chan on 6/24/23.
//

import SwiftUI

// SwiftUI view to display dessert details
struct DessertDetailView: View {
    
    // Data passed from parent view
    private var dessert: Dessert
    
    // Reference DessertDetailViewModel
    @StateObject private var dessertDetailViewModel: DessertDetailViewModel
    
    init (
        dessert: Dessert
    ) {
        self.dessert = dessert
        // Initialize view model with dessert parameter
        _dessertDetailViewModel = StateObject(wrappedValue: DessertDetailViewModel(dessert: dessert))
    }
    
    var body: some View {
        ScrollView {
            VStack{
                // Display meal name
                Text(dessertDetailViewModel.dessertDetail?.strMeal ?? "")
                // Display meal thumbnail or placeholder loader if not ready
                AsyncImage(url: URL(string: dessertDetailViewModel.dessertDetail?.strMealThumb ?? ""), content: { image in
                    image.resizable()
                }, placeholder: {
                    ProgressView()
                })
                .frame(width: 200, height: 200)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                // Display non-nil measurements and ingredients
                ForEach(dessertDetailViewModel.dessertDetail?.ingredientMeasurementList ?? [], id:\.self) { lst in
                    HStack {
                        Text(lst[1])
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        Text(lst[0])
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                Spacer()
                // Display instructions
                Text(dessertDetailViewModel.dessertDetail?.strInstructions ?? "")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
            }
        }
        .onAppear {
            dessertDetailViewModel.getDessertDetails()
        }
    }
}

struct DessertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let dessert = Dessert(strMeal: "Portuguese prego with green piri-piri", strMealThumb: "https://www.themealdb.com/images/media/meals/ewcikl1614348364.jpg", idMeal: "53042")
        DessertDetailView(dessert: dessert)
    }
}
