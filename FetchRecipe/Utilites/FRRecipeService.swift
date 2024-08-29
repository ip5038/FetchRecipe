import Foundation

/// This class will handle all the API calls
class FRRecipeService
{
    static let shared = FRRecipeService()
    private let kListMealsURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    // Append the meal id to string before calling API
    private let kGetMealDetailsURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    func fetchDesserts() async throws -> [FRMeal]
    {
        guard let url = URL(string: kListMealsURL) else { return [] }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpRes = response as? HTTPURLResponse, httpRes.statusCode == 200 else { throw URLError(.badServerResponse) }
        let dessertsResponse = try JSONDecoder().decode(FRMealsResponse.self, from: data)
        
        return dessertsResponse.meals
    }
    
    func fetchMealDetails(with mealID: String) async throws -> FRMealDetails?
    {
        let urlString = kGetMealDetailsURL + mealID
        guard let url = URL(string: urlString) else {
            print("Invalid meals detail URL")
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let mealResponse = try JSONDecoder().decode(FRMealDetailsResponse.self, from: data)
        
        return mealResponse.meals.first
    }
}

