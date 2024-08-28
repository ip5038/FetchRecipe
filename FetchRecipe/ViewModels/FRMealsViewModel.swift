//
//  FRMealsViewModel.swift
//  FetchRecipe
//
//  Created by Ishan Patel on 8/28/24.
//

import Foundation
import UIKit

class FRMealsViewModel: NSObject
{
    private var dessertImages: [String: UIImage] = [:]
    var desserts: [FRMeal] = []
    
    override init()
    {
        super.init()
    }

    func fetchDesserts() async
    {
        do
        {
            let dessertsRes = try await FRRecipeService.shared.fetchDesserts()
            self.desserts = dessertsRes

        }
        catch
        {
            print("Error fetching desserts: \(error)")
        }
    }
    
    func getImage(mealId: String) -> UIImage?
    {
        return dessertImages[mealId]
    }
    
    func saveImage(mealId: String, image: UIImage)
    {
        dessertImages[mealId] = image
    }
    
    func getMealDetails(indexPath: IndexPath) async throws -> FRMealDetails?
    {
        
        do
        {
            let selectedMeal = desserts[indexPath.row]
            guard let mealDetails = try await FRRecipeService.shared.fetchMealDetails(with: selectedMeal.idMeal) else { return nil}
            
            return mealDetails
        }
        catch let error
        {
            
            print("Error: \(error)")
            return nil
        }
        
    }
}
