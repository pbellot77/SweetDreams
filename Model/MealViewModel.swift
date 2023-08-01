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
    @Published var error: APIError? = nil
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
  func fetchMeals() async {
      guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
          self.error = .urlNotValid
          return
      }

      do {
          let mealData: MealResponse = try await networkManager.fetchData(from: url)
          DispatchQueue.main.async {
              self.meals = mealData.meals
              self.error = nil
          }
      } catch {
          DispatchQueue.main.async {
              self.error = .invalidResponse
          }
      }
  }
}

