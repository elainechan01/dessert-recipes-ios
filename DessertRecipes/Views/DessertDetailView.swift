//
//  DessertDetailView.swift
//  DessertRecipes
//
//  Created by Elaine Chan on 6/24/23.
//

import SwiftUI

struct DessertDetailView: View {
    
    private var dessert: Dessert
    @StateObject private var dessertDetailViewModel: DessertDetailViewModel
    
    init (
        dessert: Dessert
    ) {
        self.dessert = dessert
        _dessertDetailViewModel = StateObject(wrappedValue: DessertDetailViewModel(dessert: dessert))
    }
    
    var body: some View {
        ScrollView {
            VStack{
                Text(dessertDetailViewModel.dessertDetail?.strMeal ?? "")
                AsyncImage(url: URL(string: dessertDetailViewModel.dessertDetail?.strMealThumb ?? ""), content: { image in
                    image.resizable()
                }, placeholder: {
                    ProgressView()
                })
                .frame(width: 200, height: 200)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                ForEach(dessertDetailViewModel.dessertDetail?.ingredientMeasurementList ?? [], id:\.self) { lst in
                    HStack {
                        Text(lst[1])
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        Text(lst[0])
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                Spacer()
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
