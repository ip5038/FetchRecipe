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
    private var mealImagesCache: [String: UIImage] = [:]
    var meals: [FRMeal] = []
    
    override init()
    {
        super.init()
    }

    func fetchDesserts() async
    {
        do
        {
            let dessertsRes = try await FRRecipeService.shared.fetchDesserts()
            self.meals = dessertsRes
            sortAndFilterMeals()
        }
        catch
        {
            print("Error fetching desserts: \(error)")
        }
    }
    
    private func sortAndFilterMeals()
    {
        // Remove any meals with missing info
        self.meals = meals.filter { currMeal in
            return !currMeal.strMeal.isEmpty && !currMeal.strMealThumb.isEmpty && !currMeal.idMeal.isEmpty
        }
        self.meals.sort(by: { $0.strMeal < $1.strMeal })
    }
    
    func getImage(imageUrl: String, mealId: String) async throws -> UIImage?
    {
        if (mealImagesCache[mealId] == nil)
        {
            do
            {
                let imgUrl = URL(string: imageUrl)!
                let data = try await self.downloadImage(imgUrl)
                if let img = UIImage(data: data)
                {
                    //  self.saveImage(mealId: mealId, image: img) TODO: cache this image. Crashing due to concurrency issues
                    return img
                }
                else
                {
                    return nil
                }
            }
            catch
            {
                print("Error downloading recipe image: \(error.localizedDescription)")
                throw error
            }
        }
        else
        {
            return mealImagesCache[mealId]
        }
    }
    
    func saveImage(mealId: String, image: UIImage)
    {
        mealImagesCache[mealId] = image
    }
    
    func getMealDetails(indexPath: IndexPath) async throws -> FRMealDetails?
    {
        do
        {
            let selectedMeal = meals[indexPath.row]
            guard let mealDetails = try await FRRecipeService.shared.fetchMealDetails(with: selectedMeal.idMeal) else { return nil}
            
            return mealDetails
        }
        catch let error
        {
            print("Error: \(error)")
            return nil
        }
    }
    
    func downloadImage(_ url: URL) async throws -> Data
    {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
