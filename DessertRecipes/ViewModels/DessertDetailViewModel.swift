//
//  DessertDetailViewModel.swift
//  DessertRecipes
//
//  Created by Elaine Chan on 6/25/23.
//

import Foundation

/// Class to implement business logic for DessertDetail model
final class DessertDetailViewModel: ObservableObject {
    
    // Variable instantiation and private initialization method
    // Create observable object list of Dessert
    @Published var dessertDetail: DessertDetail? = nil
    // Initialize dessert parameter
    private let dessert: Dessert
    init (dessert: Dessert) {
        self.dessert = dessert
    }
    
    /**
     Function to lookup dessert details
     Exampled response:
     {
         "meals": [
             {
                 "idMeal": "53042",
                 "strMeal": "Portuguese prego with green piri-piri",
                 "strDrinkAlternate": null,
                 "strCategory": "Beef",
                 "strArea": "Portuguese",
                 "strInstructions": "STEP 1\r\n\r\nRub the garlic over the steaks then put in a sandwich bag and tip in the olive oil, sherry vinegar and parsley stalks. Smoosh everything together, then use a rolling pin to bash the steaks a few times. Leave for 1-2 hours.\r\n\r\nSTEP 2\r\n\r\nTo make the sauce, put all the ingredients into a blender with 1 tbsp water and whizz until as smooth as possible. This will make more than you’ll need for the recipe but will keep for a week in an airtight jar.\r\n\r\nSTEP 3\r\n\r\nHeat a griddle or frying pan to high. Brush away the garlic and parsley stalks from the steaks and season well. Sear the steaks for 2 minutes on each side then rest on a plate. Put the ciabatta halves onto the plate, toasted-side down, to soak up any juices.\r\n\r\nSTEP 4\r\n\r\nSlice the steaks then stuff into the rolls with the green sauce and rocket.",
                 "strMealThumb": "https://www.themealdb.com/images/media/meals/ewcikl1614348364.jpg",
                 "strTags": null,
                 "strYoutube": "https://www.youtube.com/watch?v=FbIKfcDEPLA",
                 "strIngredient1": "Garlic",
                 "strIngredient2": "Beef Fillet",
                 "strIngredient3": "Olive Oil",
                 "strIngredient4": "Vinegar",
                 "strIngredient5": "Parsley",
                 "strIngredient6": "Ciabatta",
                 "strIngredient7": "Rocket",
                 "strIngredient8": "Basil Leaves",
                 "strIngredient9": "Parsley",
                 "strIngredient10": "Jalapeno",
                 "strIngredient11": "Vinegar",
                 "strIngredient12": "Spring Onions",
                 "strIngredient13": "Garlic",
                 "strIngredient14": "Caster Sugar",
                 "strIngredient15": "",
                 "strIngredient16": "",
                 "strIngredient17": "",
                 "strIngredient18": "",
                 "strIngredient19": "",
                 "strIngredient20": "",
                 "strMeasure1": "1 clove",
                 "strMeasure2": "2 small",
                 "strMeasure3": "2 tbs",
                 "strMeasure4": "1 tbs",
                 "strMeasure5": "Leaves",
                 "strMeasure6": "2",
                 "strMeasure7": "2 handfulls",
                 "strMeasure8": "Small bunch",
                 "strMeasure9": "Small bunch",
                 "strMeasure10": "1",
                 "strMeasure11": "1 tbs",
                 "strMeasure12": "2 chopped",
                 "strMeasure13": "1/2 ",
                 "strMeasure14": "1/2 tsp",
                 "strMeasure15": " ",
                 "strMeasure16": " ",
                 "strMeasure17": " ",
                 "strMeasure18": " ",
                 "strMeasure19": " ",
                 "strMeasure20": " ",
                 "strSource": "https://www.olivemagazine.com/recipes/meat-and-poultry/portuguese-prego-with-green-piri-piri/",
                 "strImageSource": null,
                 "strCreativeCommonsConfirmed": null,
                 "dateModified": null
             }
         ]
     }
     */
    public func getDessertDetails() {
        // Build MealdbRequest. Reference: https://themealdb.com/api.php @ June 2023
        //  e.g. https://themealdb.com/api/json/v1/1/lookup.php?i=53042
        let request = MealdbRequest(endpoint: .lookup, queryItems: ["i": self.dessert.idMeal])
        // Build MealdbService with DessertDetailList expected type
        MealdbService.shared.run(request, expecting: DessertDetailList.self) { [weak self] result in
            switch result {
            // Handle errors thrown - print to console
            case .failure(let error):
                print("Error found: \(error)")
            // Parse meals from response
            case .success(let model):
                DispatchQueue.main.async {
                    // Store first DessertDetail in response in observable object
                    self?.dessertDetail = model.meals.first
                }
            }
        }
    }
    
}
