//
//  MealDetailViewModel.swift
//  SweetDreams
//
//  Created by Patrick Bellot on 7/27/23.
//

import Foundation
import Combine

class MealDetailViewModel: ObservableObject {
    @Published var meal: MealDetail?
    @Published var error: APIError?
  
    let idMeal: String
    
    init(mealId: String) {
        self.idMeal = mealId
    }
    
    func fetchMealDetail() {
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.error = .urlNotValid
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
          if error != nil {
                DispatchQueue.main.async {
                    self.error = .unknown
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    self.error = .invalidResponse
                }
                return
            }
            
            do {
                let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data!)
                DispatchQueue.main.async {
                    self.meal = mealDetailResponse.meals.first
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = .noData
                }
            }
        }
        task.resume()
    }
}
