//
//  FRMealDetailsView.swift
//  FetchRecipe
//
//  Created by Ishan Patel on 8/28/24.
//

import SwiftUI

struct FRMealDetailsView: View {
    var meal: FRMealDetails
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text(meal.strMeal)
        Button("Dismiss Me") {
            dismiss()
        }
    }
}

