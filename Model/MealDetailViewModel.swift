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
    @Published var error: APIError? = nil
    
    private let networkManager: NetworkManagerProtocol
    private let idMeal: String
    
    init(mealId: String, networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.idMeal = mealId
        self.networkManager = networkManager
    }
    
    func fetchMealDetail() async {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)") else {
            self.error = .urlNotValid
            return
        }
        
        do {
            let mealDetailResponse = try await networkManager.fetchData(from: url) as MealDetailResponse
            self.meal = mealDetailResponse.meals.first
            self.error = nil
        } catch {
            self.error = error as? APIError ?? APIError.unknown
        }
    }
}
