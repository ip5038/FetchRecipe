//
//  FRMealsViewModel.swift
//  FetchRecipe
//
//  Created by Ishan Patel on 8/28/24.
//

import Foundation
import UIKit

@MainActor
class FRMealsViewModel: NSObject
{
    private var mealImagesCache: [String: UIImage] = [:]
    var meals: [FRMeal] = []
    
    override init()
    {
        super.init()
    }

    /// Get all the desserts from meals db then sort and filter out meal with missing info.
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
    
    /// Sorts the meals alphabatically by name and removes any meal with missing info.
    private func sortAndFilterMeals()
    {
        // Remove any meals with missing info
        self.meals = meals.filter { currMeal in
            return !currMeal.strMeal.isEmpty && !currMeal.strMealThumb.isEmpty && !currMeal.idMeal.isEmpty
        }
        self.meals.sort(by: { $0.strMeal < $1.strMeal })
    }
    
    /// Returns UIImage given the image url and caches the image for later use. If the image already exsits in the cache, then return that to prevent redownloading.
    func getImage(imageUrl: String, mealId: String) async throws -> UIImage?
    {
        if (mealImagesCache[mealId] == nil)
        {
            do
            {
                let imgUrl = URL(string: imageUrl)!
                let data = try await self.downloadImage(url: imgUrl)
                if let img = UIImage(data: data)
                {
                    self.saveImage(mealId: mealId, image: img)
                    return img
                }
                else
                {
                    return nil
                }
            }
            catch
            {
                print("Error downloading image: \(error)")
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
    
    /// Returns details about a meal given the id.
    func getMealDetails(mealId: String) async throws -> FRMealDetails?
    {
        do
        {
            guard let mealDetails = try await FRRecipeService.shared.fetchMealDetails(with: mealId) else { return nil }
            return mealDetails
        }
        catch let error
        {
            print("Error getting meal details: \(error)")
            return nil
        }
    }
    
    /// Retuns image data given the image url to download.
    func downloadImage(url: URL) async throws -> Data
    {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
