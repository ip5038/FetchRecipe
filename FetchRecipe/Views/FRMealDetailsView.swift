//
//  FRMealDetailsView.swift
//  FetchRecipe
//
//  Created by Ishan Patel on 8/28/24.
//

import SwiftUI

struct FRMealDetailsView: View
{
    var mealDetails: FRMealDetails
    var mealImage: UIImage?
    private let kSpacerHeight = 25.0
    @Environment(\.dismiss) var dismiss
    @State var ingridentsAvailable: Bool = false
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(mealDetails.strMeal)
                            .font(.system(size: 32, weight: .bold))
                        
                        if (mealImage != nil)
                        {
                            Image(uiImage: mealImage!)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .frame(height: 300)
                        }
                        
                        Spacer()
                            .frame(height: kSpacerHeight)
                       
                        Text("Ingredients")
                            .font(.system(size: 18, weight: .semibold))
                        
                        // Try to dynamically get ingrident and measurement. If both are not nil, then show the text
                        ForEach(1...20, id: \.self) { index in
                            let ingredientKeyPath = FRMealDetails.getIngredientKeyPath(index)
                            let measureKeyPath = FRMealDetails.getMeasureKeyPath(index)
                            
                            if let ingredient = mealDetails[keyPath: ingredientKeyPath],
                               let measure = mealDetails[keyPath: measureKeyPath]
                            {
                                if (!ingredient.isEmpty && !measure.isEmpty)
                                {
                                    Text("\(ingredient) - \(measure)")
                                }
                            }
                        }
                        
                        if (!ingridentsAvailable)
                        {
                            Text("No ingredients available.")
                                .font(.system(size: 16, weight: .regular))
                                .italic()
                        }

                        Spacer()
                            .frame(height: kSpacerHeight)
                        
                        Text("Instructions")
                            .font(.system(size: 18, weight: .semibold))
                        if (!mealDetails.strInstructions.isEmpty)
                        {
                            Text(mealDetails.strInstructions)
                        }
                        else
                        {
                            Text("No instructions available.")
                                .font(.system(size: 16, weight: .regular))
                                .italic()
                        }
                    }
                    .padding()
                }
            }
            .navigationBarItems(leading: backButton)
        }
        .onAppear {
            areIngridentsAvailable()
        }
    }
    
    private var backButton: some View
    {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
        }
    }
    
    private func areIngridentsAvailable()
    {
        for index in 1...20
        {
            let ingredientKeyPath = FRMealDetails.getIngredientKeyPath(index)
            let measureKeyPath = FRMealDetails.getMeasureKeyPath(index)
            
            if let ingredient = mealDetails[keyPath: ingredientKeyPath],
               let measure = mealDetails[keyPath: measureKeyPath],
               !ingredient.isEmpty, !measure.isEmpty
            {
                ingridentsAvailable = true
                return
            }
        }
        ingridentsAvailable = false
    }
    
}

