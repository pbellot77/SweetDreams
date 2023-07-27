// MealView.swift
// SweetDreams
//
// Created by Patrick Bellot on 7/27/23.

import SwiftUI

struct MealView: View {
  @ObservedObject var viewModel = MealViewModel()
  
  var body: some View {
    NavigationView {
      List(viewModel.meals) { meal in
        NavigationLink(destination: MealDetailView(viewModel: MealDetailViewModel(mealId: meal.idMeal))) {
          HStack {
            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
              image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(Color.black.opacity(0.1))
            } placeholder: {
              ProgressView()
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .clipped()
            .cornerRadius(10)
            .shadow(radius: 5)
          
            Text(meal.strMeal)
              .font(.headline)
          }
        }
      }
      .navigationTitle("Desserts")
      .onAppear(perform: viewModel.fetchMeals)
      .alert(isPresented: Binding<Bool>.constant(viewModel.error != nil), content: {
        Alert(title: Text("Error"), message: Text(viewModel.error?.localizedDescription ?? "Unknown Error"), dismissButton: .default(Text("OK")))
      })
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MealView()
  }
}
