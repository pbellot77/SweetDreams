//
//  MealDetailViewModelTests.swift
//  SweetDreamsTests
//
//  Created by Patrick Bellot on 8/1/23.
//

import XCTest
@testable import SweetDreams

class MealDetailViewModelTests: XCTestCase {
    var viewModel: MealDetailViewModel!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = MealDetailViewModel(mealId: "1", networkManager: mockNetworkManager)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }

    func testFetchMealDetailSuccess() async throws {
        // Create a mock response data for successful API call
        let jsonData = """
            {
                "meals": [
                    {
                        "idMeal": "1",
                        "strMeal": "Meal 1",
                        "strMealThumb": "https://www.example.com/meal1.jpg",
                        "strInstructions": "Instructions for Meal 1"
                    }
                ]
            }
        """.data(using: .utf8)

        // Set the mock data for the network manager
        mockNetworkManager.mockData = jsonData

        // Call the fetchMealDetail method
        await viewModel.fetchMealDetail()

        // Assert that the meal detail is loaded successfully
        XCTAssertNotNil(viewModel.meal)
        XCTAssertEqual(viewModel.meal?.strMeal, "Meal 1")
    }

    func testFetchMealDetailFailure() async throws {
        // Create a mock error for a failed API call
        let error = NSError(domain: "MockErrorDomain", code: 42, userInfo: nil)

        // Set the mock error for the network manager
        mockNetworkManager.mockError = error

        // Call the fetchMealDetail method
        await viewModel.fetchMealDetail()

        // Assert that the error is set
        XCTAssertNotNil(viewModel.error)
    }
}
