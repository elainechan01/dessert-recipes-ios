# Dessert Recipes iOS App

![GIF Walkthrough](/DessertRecipes/Resources/walkthrough.gif)

# Description
iOS App to display desserts from [themealdb.com](https://themealdb.com)

# Getting Started
1. The app is compatible with the latest XCode (version 14.0 or above).
2. Download the project files from the repository `git clone https://github.com/elainechan01/dessert-recipes-ios.git`
3. Open the project files in XCode.
4. Run the active scheme

# Architecture
Project is implemented using the Model-View-ViewModel (MVVM) architecture.
### Data Flow
- Navigation screen (main) displays desserts alphabetically from endpoint `https://themealdb.com/api/json/v1/1/filter.php?c=Dessert`
- When user navigates to the dessert details screen, program attempts to retrieve details from cache or if not found, displays details from endpoint `https://themealdb.com/api/json/v1/1/lookup.php?i=<idMeal>`
- Dessert details are stored in cache if not previously present
### Structure
```
- Managers
    |__APIClient
    |__Cache
- Models
- Resources
- ViewModels
- Views
    |__Utilities
```
- Managers: Files to manage network data
- Models: Files to structure network data
- Resources: Non-code files used by project
- ViewModels: Files to implement business logic between views and models
- Views: Files to display data
### Running Tests
The app can be tested using the built-in framework XCTest. Tests have been created and can be run from `DessertRecipesTests.swift`
- testBuildFilterUrl
- testBuildFilterDessertsUrl
- testBuildLookupDessertDetailUrl
- testFilterDesserts
- testLookupDessertDetail
- testFilterDessertsAsPublished
- testTestLookupDessertDetailAsPublished
### API

[TheMealDB](https://themealdb.com/api)

| Method | Endpoint   |  Parameters   | Description         |
| ------ | ---------- | --- | ------------------- |
| `GET`  | filter.php |  c=Dessert   | Filters meals       |
| `GET`  | lookup.php |  i=\<idMeal>   | Lookup meal details |
