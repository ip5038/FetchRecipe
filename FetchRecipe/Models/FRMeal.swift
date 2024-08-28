import Foundation

struct FRMeal: Codable
{
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

struct FRMeals: Codable
{
    let meals: [FRMeal]
}
