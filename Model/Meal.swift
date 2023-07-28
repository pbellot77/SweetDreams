//
//  Meal.swift
//  SweetDreams
//
//  Created by Patrick Bellot on 7/27/23.
//

import Foundation

//--Model for Meal view
struct Meal: Codable, Identifiable {
  let idMeal: String
  let strMeal: String
  let strMealThumb: String
  
  var id: String {
    return idMeal
  }
}

// Response
struct MealResponse: Codable {
  let meals: [Meal]
}
