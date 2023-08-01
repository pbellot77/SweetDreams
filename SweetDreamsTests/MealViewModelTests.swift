//
//  MealViewModelTests.swift
//  SweetDreamsTests
//
//  Created by Patrick Bellot on 8/1/23.
//

import XCTest
@testable import SweetDreams

class MealViewModelTests: XCTestCase {
    var viewModel: MealViewModel!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = MealViewModel(networkManager: mockNetworkManager)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }

  
  func testFetchMealsSuccess() async {
      // Create an expectation for the API call to complete
      let expectation = XCTestExpectation(description: "Fetch meals expectation")

      // Create a mock response data for successful API call
      let jsonData = """
          {
              "meals": [
                  {
                      "idMeal": "1",
                      "strMeal": "Meal 1",
                      "strMealThumb": "https://www.example.com/meal1.jpg"
                  }
              ]
          }
      """.data(using: .utf8)

      // Set the mock data for the network manager
      mockNetworkManager.mockData = jsonData

      // Call the fetchMeals method using Swift concurrency
      await viewModel.fetchMeals()

      // Use DispatchQueue to introduce a short delay (e.g., 100 milliseconds) to allow the data to be set
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
          // Assert that the meals are loaded successfully
          XCTAssertEqual(viewModel.meals.count, 1)
          XCTAssertEqual(viewModel.meals[0].strMeal, "Meal 1")

          // Fulfill the expectation after the assertions are made
          expectation.fulfill()
      }

      // Wait for the expectation to be fulfilled
      await fulfillment(of: [expectation], timeout: 5)
  }
}


