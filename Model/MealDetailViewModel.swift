//
//  MealDetailViewModel.swift
//  SweetDreams
//
//  Created by Patrick Bellot on 7/27/23.
//

import Foundation

class MealDetailViewModel: ObservableObject {
  @Published var meal: MealDetail?
  @Published var error: Error?
  
  let idMeal: String
  
  init(mealId: String) {
    self.idMeal = mealId
  }
  
  func fetchMealDetail() {
    let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)"
    guard let url = URL(string: urlString) else { return }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        DispatchQueue.main.async {
          self.error = error
        }
        return
      }
      
      do {
        let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data!)
        DispatchQueue.main.async {
          self.meal = mealDetailResponse.meals[0]
        }
      } catch {
        DispatchQueue.main.async {
          self.error = error
        }
      }
    }
    task.resume()
  }
}
