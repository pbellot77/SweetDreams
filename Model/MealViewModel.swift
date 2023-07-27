//
//  ViewModel.swift
//  SweetDreams
//
//  Created by Patrick Bellot on 7/27/23.
//

import Foundation
import Combine

class MealViewModel: ObservableObject {
  @Published var meals = [Meal]()
  @Published var selectedMeal: Meal? = nil
  @Published var error: APIError? = nil
  
  func fetchMeals() {
    guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
      self.error = .urlNotValid
      return
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let _ = error {
        DispatchQueue.main.async {
          self.error = .unknown
        }
        return
      }
      
      guard let data = data else {
        DispatchQueue.main.async {
          self.error = .invalidResponse
        }
        return
      }
      
      do {
        let mealData = try JSONDecoder().decode(MealResponse.self, from: data)
        
        DispatchQueue.main.async {
          self.meals = mealData.meals
          self.error = nil
        }
      } catch {
        DispatchQueue.main.async {
          self.error = .invalidResponse
        }
      }
    }.resume()
  }
  
  func fetchMealDetails(for mealID: String) {
    guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else {
      self.error = .urlNotValid
      return
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let _ = error {
        DispatchQueue.main.async {
          self.error = .unknown
        }
        return
      }
      
      guard let data = data else {
        DispatchQueue.main.async {
          self.error = .invalidResponse
        }
        return
      }
      
      do {
        let mealData = try JSONDecoder().decode(MealResponse.self, from: data)
        DispatchQueue.main.async {
          self.selectedMeal = mealData.meals.first
          self.error = nil
        }
      } catch {
        DispatchQueue.main.async {
          self.error = .invalidResponse
        }
      }
    }.resume()
  }
}

