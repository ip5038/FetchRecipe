import Foundation

/// This class will handle all the API calls
class FRRecipeService
{
    static let shared = FRRecipeService()
    private let kListMealsURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    // append the meal id to string before calling API
    private let kGetMealDetailsURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    private let frMealJsonData = """
{
    "meals":[
        {
            "strMeal":"Apam balik",
            "strMealThumb":"https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
            "idMeal":"53049"
        },
        {
            "strMeal":"Apple & Blackberry Crumble",
            "strMealThumb":"https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
            "idMeal":"52893"
        }
        // More meal objects...
    ]
}
""".data(using: .utf8)!
    
    func fetchDesserts() async throws -> [FRMeal]
    {
        guard let url = URL(string: kListMealsURL) else { return [] }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpRes = response as? HTTPURLResponse, httpRes.statusCode == 200 else { throw URLError(.badServerResponse) }
        
        let dessertsResponse = try JSONDecoder().decode(FRMeals.self, from: data)
        
        return dessertsResponse.meals
    }
    
    func fetchMealDetails(with mealID: String) async -> FRMeal?
    {
        return nil
    }
    
    func downloadImage(_ url: URL) async throws -> Data
    {
       let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}

