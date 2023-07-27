//
//  MealDetailView.swift
//  SweetDreams
//
//  Created by Patrick Bellot on 7/27/23.
//

import SwiftUI

struct MealDetailView: View {
    @ObservedObject var viewModel: MealDetailViewModel

    var body: some View {
        ScrollView {
            VStack {
                if let meal = viewModel.meal {
                    AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay(Color.black.opacity(0.2))
      
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        Rectangle()
                          .fill(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .center, endPoint: .bottom))
                    )
                    .shadow(radius: 5)

                    Text(meal.strMeal)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom)
                  
                  Text("Ingredients")
                      .font(.title2)
                      .fontWeight(.bold)
                      .padding(.vertical)

                  ForEach(meal.ingredients, id: \.self) { ingredient in
                      Text(ingredient)
                          .font(.body)
                  }

                    Text("Instructions")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.vertical)

                    Text(meal.strInstructions)
                        .font(.body)
                        .foregroundColor(.black)             
                }
            }
            .padding()
            .background(Color.white)
        }
        .onAppear(perform: viewModel.fetchMealDetail)
        .alert(isPresented: Binding<Bool>.constant(viewModel.error != nil), content: {
            Alert(title: Text("Error"), message: Text(viewModel.error?.localizedDescription ?? "Unknown Error"), dismissButton: .default(Text("OK")))
        })
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(viewModel: MealDetailViewModel(mealId: "53049"))
    }
}

